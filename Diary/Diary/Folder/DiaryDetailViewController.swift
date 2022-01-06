//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by 장선영 on 2022/01/04.
//

import UIKit

protocol DiaryDetailViewDelegate: AnyObject {
    func didSelectDelete(indexpath: IndexPath)
    func didSelectStar(indexPath: IndexPath, isStar: Bool)
}

class DiaryDetailViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let label4: UILabel = {
        let label = UILabel()
        label.text = "날짜"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(editDiary), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.addTarget(self, action: #selector(deleteDiary), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let stackView3: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var diary: Diary?
    var indexPath: IndexPath?
    weak var delegate: DiaryDetailViewDelegate?
    var starButton: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        view.addSubview(label3)
        view.addSubview(contentTextView)
        view.addSubview(stackView2)
        view.addSubview(stackView3)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(titleLabel)
        
        label3.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24).isActive = true
        label3.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        label3.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        
        contentTextView.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 12).isActive = true
        contentTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 20).isActive = true
        contentTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: 20).isActive = true
        contentTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        stackView2.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 24).isActive = true
        stackView2.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        stackView2.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        stackView2.addArrangedSubview(label4)
        stackView2.addArrangedSubview(dateLabel)
        
        stackView3.topAnchor.constraint(equalTo: stackView2.bottomAnchor,constant: 24).isActive = true
        stackView3.centerXAnchor.constraint(equalTo: stackView2.centerXAnchor).isActive = true
        stackView3.addArrangedSubview(editButton)
        stackView3.addArrangedSubview(deleteButton)
        
        configureView()
    }
    
    private func configureView() {
        guard let diary = self.diary else { return }
        
        self.titleLabel.text = diary.title
        self.contentTextView.text = diary.content
        self.dateLabel.text = self.dateToString(date: diary.date)
        self.starButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapStarButton))
        self.starButton?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.starButton?.tintColor = .orange
        self.navigationItem.rightBarButtonItem = self.starButton
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    @objc func tapStarButton() {
        guard let isStar = diary?.isStar else { return }
        guard let indexPath = self.indexPath else { return }
        
        if isStar {
            self.starButton?.image = UIImage(systemName: "star")
        } else {
            self.starButton?.image = UIImage(systemName: "star.fill")
        }
        
        self.diary?.isStar = !isStar
        self.delegate?.didSelectStar(indexPath: indexPath, isStar: !isStar)
    }
    
    @objc func deleteDiary() {
        guard let indexPath = self.indexPath else { return }
        delegate?.didSelectDelete(indexpath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func editDiary() {
        let nextVC = WriteDiaryViewController()
        guard let indexPath = self.indexPath else { return }
        guard let diary = self.diary else { return }
        nextVC.diaryMode = .edit(indexPath, diary)
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: Notification.Name("editDiary"), object: nil)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else { return }
        guard let row = notification.userInfo?["indexPath.row"] as? Int else { return }
        
        self.diary = diary
        self.configureView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
