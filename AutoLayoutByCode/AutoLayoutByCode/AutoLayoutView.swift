//
//  AutoLayoutView.swift
//  AutoLayoutByCode
//
//  Created by 장선영 on 2021/12/12.
//

import UIKit

class AutoLayoutView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "랜덤 색상"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let colorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let colorButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("색상 변경", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeViewColor), for: .touchUpInside)
        
        return  button
    }()
    
    @objc func changeViewColor() {
        self.colorView.backgroundColor = .blue
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.addSubview(titleLabel)
        self.addSubview(colorView)
        self.addSubview(colorButton)
        
        let safeArea = self.safeAreaLayoutGuide
        
        self.titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 20).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -20).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30).isActive = true
        
        self.colorView.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor).isActive = true
        self.colorView.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor).isActive = true
        self.colorView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 30).isActive = true
        self.colorView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        self.colorButton.leftAnchor.constraint(equalTo: self.colorView.leftAnchor).isActive = true
        self.colorButton.rightAnchor.constraint(equalTo: self.colorView.rightAnchor).isActive = true
        self.colorButton.topAnchor.constraint(equalTo: self.colorView.bottomAnchor, constant: 30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
