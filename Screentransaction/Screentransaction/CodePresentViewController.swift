//
//  CodePresentViewController.swift
//  Screentransaction
//
//  Created by 장선영 on 2021/12/13.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func sendData(name: String)
}

class CodePresentViewController: UIViewController {
    
    weak var delegate: SendDataDelegate?
        
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "코드로 present"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var contentLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Back Button", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    @objc func tapBackButton() {
        self.delegate?.sendData(name: "seonyoung with delegate")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
//        self.dismiss(animated: true, completion: nil)
    }
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.view.addSubview(backButton)
        self.view.addSubview(contentLabel)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30).isActive = true
        
        self.backButton .topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        self.backButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        
        self.contentLabel .topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30).isActive = true
        self.contentLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor).isActive = true
        

    }
    
}
