//
//  ViewController.swift
//  Screentransaction
//
//  Created by 장선영 on 2021/12/13.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {
    func sendData(name: String) {
        contentLabel.text = name
    }
    
    
    let pushButton : UIButton = {
        let button = UIButton()
        
        button.setTitle("코드로 push", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapCodePushButton), for: .touchUpInside)
        
        return button
    }()
    
    // push
    @objc func tapCodePushButton(sender: UIButton) {
        let viewController = CodePushViewController()
        viewController.contentLabel.text = "seonyoung push"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    let presentButton : UIButton = {
        let button = UIButton()
        
        button.setTitle("코드로 present", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapCodePresentButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var contentLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "empty"
        label.textAlignment = .center
        
        return label
    }()
    
    // present
    @objc func tapCodePresentButton() {
        let viewController = CodePresentViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.contentLabel.text = "seonyoung present"
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(pushButton)
        self.view.addSubview(presentButton)
        self.view.addSubview(contentLabel)
        
        let safeArea = self.view.safeAreaLayoutGuide
                
        self.pushButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50).isActive = true
        self.pushButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
        
        self.presentButton.topAnchor.constraint(equalTo: pushButton.bottomAnchor, constant: 30).isActive = true
        self.presentButton.leadingAnchor.constraint(equalTo: pushButton.leadingAnchor).isActive = true
        
        self.contentLabel.topAnchor.constraint(equalTo: presentButton.bottomAnchor, constant: 30).isActive = true
        self.contentLabel.leadingAnchor.constraint(equalTo: presentButton.leadingAnchor).isActive = true
        self.contentLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        
        
    }

}

