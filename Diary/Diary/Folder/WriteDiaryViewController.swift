//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by 장선영 on 2022/01/04.
//

import UIKit

enum diaryMode {
    case new
    case edit(IndexPath, Diary)
}

protocol WriteDiaryViewDelegate: AnyObject {
    func didSelectRegister(diary: Diary)
}

class WriteDiaryViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.text = "날짜"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var confirmButton: UIBarButtonItem!
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    var delegate: WriteDiaryViewDelegate?
    var diaryMode: diaryMode = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "일기 작성"
        
        view.addSubview(label)
        view.addSubview(titleTextField)
        view.addSubview(label2)
        view.addSubview(contentTextView)
        view.addSubview(label3)
        view.addSubview(dateTextField)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        label.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24).isActive = true
        label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        
        titleTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
        
        label2.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 24).isActive = true
        label2.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        label2.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
        
        contentTextView.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 12).isActive = true
        contentTextView.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        contentTextView.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
        contentTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        label3.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 24).isActive = true
        label3.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        label3.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
        
        dateTextField.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 12).isActive = true
        dateTextField.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        dateTextField.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
        
        
        confirmButton = UIBarButtonItem(title: "등록", style: .plain, target: self, action: #selector(tapConfirmButton))
        navigationItem.rightBarButtonItem = confirmButton
        confirmButton.isEnabled = false
        
        configureDatePicker()
        configureInputField()
        configureEditMode()
    }
    
    func configureEditMode() {
        switch diaryMode {
        case let .edit(_, diary):
            self.titleTextField.text = diary.title
            self.contentTextView.text = diary.content
            self.dateTextField.text = dateToString(date: diary.date)
            self.diaryDate = diary.date
            self.confirmButton.title = "수정"
        default:
            break
        }
    }
    
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    @objc func tapConfirmButton() {
        
        guard let title = self.titleTextField.text else { return }
        guard let content = self.contentTextView.text else { return }
        guard let date = self.diaryDate else { return }
        
        
        switch self.diaryMode {
        case .new:
            let diary = Diary(uuidString: UUID().uuidString, title: title, content: content, date: date, isStar: false)
            self.delegate?.didSelectRegister(diary: diary)
            
        case let .edit(_, diary):
            let diary = Diary(uuidString: diary.uuidString, title: title, content: content, date: date, isStar: diary.isStar)
            
            NotificationCenter.default.post(
                name: Notification.Name("editDiary"),
                object: diary,
                userInfo: nil)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureDatePicker() {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.locale = Locale(identifier: "ko_KR")
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        self.dateTextField.inputView = self.datePicker
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        
        self.diaryDate = datePicker.date
        self.dateTextField.text = formatter.string(from: datePicker.date)
        self.dateTextField.sendActions(for: .editingChanged)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func configureInputField() {
        self.contentTextView.delegate = self
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidchange(_:)), for: .editingChanged)
    }
    
    private func validateInputField() {
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !(self.contentTextView.text.isEmpty)
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    @objc private func dateTextFieldDidchange(_ textField: UITextField) {
        self.validateInputField()
    }
}

extension WriteDiaryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}

