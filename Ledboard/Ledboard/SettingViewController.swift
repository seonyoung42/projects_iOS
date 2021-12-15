//
//  SettingViewController.swift
//  Ledboard
//
//  Created by 장선영 on 2021/12/13.
//

protocol SendLEDDataDelegate: AnyObject {
    func changedSetting(text: String?, textColor: UIColor, BGColor: UIColor)
}

import UIKit

class SettingViewController: UIViewController {
    
    weak var delegate: SendLEDDataDelegate?
    var ledText: String?
    var textColor: UIColor = .yellow
    var BGColor: UIColor = .black
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "전광판에 표시할 글자"
        return label
    }()
    
    
    let textField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "전광판에 표시할 글자"
        return textField
    }()
    
    let titleStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    let colorLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "텍스트 색상 설정"
        return label
    }()
    
    let colorButton1: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "yellow_circle"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapTextColorbutton(_:)), for: .touchUpInside)
        return button
    }()
    
    let colorButton2: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "purple_circle"), for: .normal)
        button.alpha = 0.2
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapTextColorbutton(_:)), for: .touchUpInside)

        return button
    }()
    
    let colorButton3: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "green_circle"), for: .normal)
        button.alpha = 0.1
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapTextColorbutton(_:)), for: .touchUpInside)

        return button
    }()
    
    let colorStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    let labelAndButtonStack: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    let BGcolorLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "배경 색상 설정"
        return label
    }()
    
    let BGcolorButton1: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "black_circle"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapBGcolorbutton(_:)), for: .touchUpInside)
        return button
    }()
    
    let BGcolorButton2: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "blue_circle"), for: .normal)
        button.alpha = 0.2
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapBGcolorbutton(_:)), for: .touchUpInside)

        return button
    }()
    
    let BGcolorButton3: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "orange_circle"), for: .normal)
        button.alpha = 0.2
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapBGcolorbutton(_:)), for: .touchUpInside)

        return button
    }()
    
    
    let BGcolorStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    let BGlabelAndButtonStack: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapSaveButton(_:)), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "설정"
        
        configureView()
        
        self.view.addSubview(titleStackView)
        self.view.addSubview(labelAndButtonStack)
        self.view.addSubview(BGlabelAndButtonStack)
        self.view.addSubview(saveButton)
        
        self.titleStackView.addArrangedSubview(titleLabel)
        self.titleStackView.addArrangedSubview(textField)

        
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.titleStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        self.titleStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        self.titleStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24).isActive = true
        
        self.titleLabel.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor).isActive = true
        
        self.textField.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor).isActive = true
        self.textField.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor).isActive = true
        
        self.saveButton.topAnchor.constraint(equalTo: BGlabelAndButtonStack.bottomAnchor, constant: 24).isActive = true
        self.saveButton.centerXAnchor.constraint(equalTo: BGlabelAndButtonStack.centerXAnchor).isActive = true
        
        setColorLabelAndbutton()
        setBGlabelAndButton()
    }
    
    
    func setColorLabelAndbutton() {
                
        [colorButton1,colorButton2,colorButton3].map {
            colorStackView.addArrangedSubview($0)
        }
        
        labelAndButtonStack.addArrangedSubview(colorLabel)
        labelAndButtonStack.addArrangedSubview(colorStackView)
        
        labelAndButtonStack.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor)
            .isActive = true
        labelAndButtonStack.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor)
            .isActive = true
        labelAndButtonStack.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 35).isActive = true
        
        colorLabel.leadingAnchor.constraint(equalTo: labelAndButtonStack.leadingAnchor).isActive = true
        colorLabel.trailingAnchor.constraint(equalTo: labelAndButtonStack.trailingAnchor).isActive = true
    }

    func setBGlabelAndButton(){
        
        [BGcolorButton1,BGcolorButton2,BGcolorButton3].map {
            self.BGcolorStackView.addArrangedSubview($0)
        }
        
        self.BGlabelAndButtonStack.addArrangedSubview(BGcolorLabel)
        self.BGlabelAndButtonStack.addArrangedSubview(BGcolorStackView)
        
        self.BGlabelAndButtonStack.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor)
            .isActive = true
        self.BGlabelAndButtonStack.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor)
            .isActive = true
        self.BGlabelAndButtonStack.topAnchor.constraint(equalTo: labelAndButtonStack.bottomAnchor, constant: 35).isActive = true
        
        self.BGcolorLabel.leadingAnchor.constraint(equalTo: BGlabelAndButtonStack.leadingAnchor).isActive = true
        self.BGcolorLabel.trailingAnchor.constraint(equalTo: BGlabelAndButtonStack.trailingAnchor).isActive = true
    }
    
    @objc func tapTextColorbutton(_ sender: UIButton) {
        if sender == colorButton1 {
            changeTextColor(color: .yellow)
            self.textColor = .yellow
        } else if sender == colorButton2 {
            changeTextColor(color: .purple)
            self.textColor = .purple
        } else {
            changeTextColor(color: .green)
            self.textColor = .green
        }
    }
    
    @objc func tapBGcolorbutton(_ sender: UIButton) {
        if sender == BGcolorButton1 {
            changeBGcolorButton(color: .black)
            self.BGColor = .black
        } else if sender == BGcolorButton2 {
            changeBGcolorButton(color: .blue)
            self.BGColor = .blue
        } else {
            changeBGcolorButton(color: .orange)
            self.BGColor = .orange
        }
    }
    
    @objc func tapSaveButton(_ sender: UIButton) {
        self.delegate?.changedSetting(text: textField.text, textColor: textColor, BGColor: BGColor)
        navigationController?.popViewController(animated: true)
    }
    
    private func changeTextColor(color: UIColor) {
        self.colorButton1.alpha = color == UIColor.yellow ? 1 : 0.2
        self.colorButton2.alpha = color == UIColor.purple ? 1 : 0.2
        self.colorButton3.alpha = color == UIColor.green ? 1 : 0.2
    }
    
    private func changeBGcolorButton(color: UIColor) {
        self.BGcolorButton1.alpha = color == UIColor.black ? 1 : 0.2
        self.BGcolorButton2.alpha = color == UIColor.blue ? 1 : 0.2
        self.BGcolorButton3.alpha = color == UIColor.orange ? 1 : 0.2
    }
    
    private func configureView() {
        if let ledText = ledText {
            textField.text = ledText
        }
        self.changeTextColor(color: textColor)
        self.changeBGcolorButton(color: BGColor)
    }
}
