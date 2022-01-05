//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by 장선영 on 2022/01/04.
//

import UIKit

class DiaryDetailViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label2: UILabel = {
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
    
    let textView: UITextView = {
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
    
    let label5: UILabel = {
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
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let button2: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        view.addSubview(label3)
        view.addSubview(textView)
        view.addSubview(stackView2)
        view.addSubview(stackView3)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(label2)
        
        label3.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24).isActive = true
        label3.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        label3.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        
        textView.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 12).isActive = true
        textView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: 20).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        stackView2.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 24).isActive = true
        stackView2.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        stackView2.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        stackView2.addArrangedSubview(label4)
        stackView2.addArrangedSubview(label5)
        
        stackView3.topAnchor.constraint(equalTo: stackView2.bottomAnchor,constant: 24).isActive = true
        stackView3.centerXAnchor.constraint(equalTo: stackView2.centerXAnchor).isActive = true
        stackView3.addArrangedSubview(button)
        stackView3.addArrangedSubview(button2)
        
    }

}
