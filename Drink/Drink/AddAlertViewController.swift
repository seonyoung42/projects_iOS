//
//  AddAlertViewController.swift
//  Drink
//
//  Created by 장선영 on 2022/01/13.
//

import UIKit

class AddAlertViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let datepicker = UIDatePicker()
        datepicker.preferredDatePickerStyle == .inline
        datepicker.datePickerMode == .time
        datepicker.locale = Locale(identifier: "ko_KR")
        datepicker.translatesAutoresizingMaskIntoConstraints = false
        return datepicker
    }()
    
    let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
//        navigationBar.title
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    
    var pickedDate: ((_ date: Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        self.navigationController?.title = "알람 추가"
        
        let leftButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(tapDismissButton))
        let rightButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(tapSaveButton))

        navigationItem.rightBarButtonItem = rightButton
        navigationItem.leftBarButtonItem = leftButton
        
        self.view.addSubview(label)
        self.view.addSubview(datePicker)
        self.view.addSubview(navigationBar)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 80).isActive = true
        
        datePicker.widthAnchor.constraint(equalToConstant: 193).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        
        navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
    }
    
    @objc func tapDismissButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tapSaveButton() {
        pickedDate?(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
}
