//
//  ViewController.swift
//  Pomodoro
//
//  Created by 장선영 on 2022/01/05.
//

import UIKit
import AudioToolbox

enum TimerStatus {
    case start
    case pause
    case end
}

class ViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pomodoro")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
//        label.isHidden = true
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 1
//        progressView.isHidden = true
        progressView.alpha = 0
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerStyle == .wheels
        datePicker.datePickerMode = .countDownTimer
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .disabled)
        button.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let toggleButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작", for: .normal)
        button.setTitle("일시정지", for: .selected)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapToggleButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 80
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var duration = 60
    var timerStatus: TimerStatus = .end
    var timer: DispatchSourceTimer?
    var currentSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(timerLabel)
        view.addSubview(progressView)
        view.addSubview(datePicker)
        view.addSubview(stackView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        
        timerLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 80).isActive = true
        timerLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        
        progressView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30).isActive = true
        progressView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 48).isActive = true
        progressView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -48).isActive = true
        
        datePicker.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 24).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 24).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(toggleButton)
    }

    @objc func tapCancelButton() {
        switch self.timerStatus {
        case .start, .pause:
            self.stopTimer()
        default:
            break
        }
    }
    
    @objc func tapToggleButton() {
        self.duration = Int(self.datePicker.countDownDuration)

        switch self.timerStatus {
        case .end:
            timerStatus = .start
            self.currentSeconds = self.duration
//            setTimerInfoViewVisible(isHidden: false)
//            datePicker.isHidden = true
            UIView.animate(withDuration: 0.5) {
                self.timerLabel.alpha = 1
                self.progressView.alpha = 1
                self.datePicker.alpha = 0
            }
            
            toggleButton.isSelected = true
            cancelButton.isEnabled = true
            startTimer()
        case .start:
            timerStatus = .pause
            toggleButton.isSelected = false
            self.timer?.suspend()
        case .pause:
            timerStatus = .start
            toggleButton.isSelected = true
            self.timer?.resume()
        default:
            break
        }
    }

    func setTimerInfoViewVisible(isHidden: Bool) {
        self.timerLabel.isHidden = isHidden
        self.progressView.isHidden = isHidden
    }
    
    func startTimer() {
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.timer?.schedule(deadline: .now(), repeating: 1)
            self.timer?.setEventHandler { [weak self] in
                guard let self = self else { return }
                self.currentSeconds -= 1
                let hour = self.currentSeconds/3600
                let minutes = (self.currentSeconds%3600)/60
                let seconds = (self.currentSeconds%3600)%60
                
                self.timerLabel.text = String(format: "%02d:%02d:%02d", hour,minutes,seconds)
                
                self.progressView.progress = Float(self.currentSeconds) / Float(self.duration)
                UIView.animate(withDuration: 0.25, delay: 0) {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi/2)
                }
                UIView.animate(withDuration: 0.25, delay: 0.25) {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
                }
                UIView.animate(withDuration: 0.25, delay: 0.5) {
                    self.imageView.transform = CGAffineTransform(rotationAngle: (.pi/2)*3)
                }
                UIView.animate(withDuration: 0.25, delay: 0.75) {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi*2)
                }
                if self.currentSeconds <= 0 {
                    // timer ends
                    self.stopTimer()
                    // > http://iphonedev.wiki/index.php/AudioServices 에서 AudionService 번호 확인가능
                    AudioServicesPlaySystemSound(1005)
                }
            }
            self.timer?.resume()
        }
    }
    
    func stopTimer() {
        // > 일시정지인 경우 suspend상태였기 때문에 resume을하고 cancel해야 에러가 나지 않음
        if self.timerStatus == .pause {
            self.timer?.resume()
        }
        
        self.timer?.cancel()
        self.timer = nil
        
        timerStatus = .end
        cancelButton.isEnabled = false
//        setTimerInfoViewVisible(isHidden: true)
//        datePicker.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.timerLabel.alpha = 0
            self.progressView.alpha = 0
            self.datePicker.alpha = 1
            self.imageView.transform = .identity
        }
        toggleButton.isSelected = false
    }
}

