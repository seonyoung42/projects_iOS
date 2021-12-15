//
//  ViewController.swift
//  Ledboard
//
//  Created by 장선영 on 2021/12/13.
//

import UIKit

class ViewController: UIViewController, SendLEDDataDelegate {
    
    func changedSetting(text: String?, textColor: UIColor, BGColor: UIColor) {
        if let text = text {
            self.nameLabel.text = text
        }
        self.nameLabel.textColor = textColor
        self.view.backgroundColor = BGColor
    }
    
    
    let nameLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "empty"
        label.textAlignment = .center
        label.textColor = .systemYellow
        label.font = UIFont.systemFont(ofSize: 50)
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.view.addSubview(nameLabel)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.nameLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        self.nameLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: #selector(moveToSettingView))
    }
    
    @objc func moveToSettingView() {
        let viewController = SettingViewController()
        viewController.delegate = self
        viewController.ledText = nameLabel.text
        viewController.textColor = nameLabel.textColor
        viewController.BGColor = view.backgroundColor ?? .black
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

