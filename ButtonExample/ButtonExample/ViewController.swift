//
//  ViewController.swift
//  ButtonExample
//
//  Created by 장선영 on 2021/12/19.
//

import UIKit

class ViewController: UIViewController {
    
    let button : RoundButton = {
        
        let button = RoundButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .yellow
        
        return button
    }()
    
    
    let subView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue

        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(subView)
        self.subView.addSubview(button)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.subView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        self.subView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        self.subView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        self.subView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        self.button.centerXAnchor.constraint(equalTo: self.subView.centerXAnchor).isActive = true
        self.button.centerYAnchor.constraint(equalTo: self.subView.centerYAnchor).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.button.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.button.isRound = true
    }
}

