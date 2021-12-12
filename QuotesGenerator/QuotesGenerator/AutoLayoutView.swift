//
//  AutoLayoutView.swift
//  QuotesGenerator
//
//  Created by 장선영 on 2021/12/12.
//

import UIKit

class AutoLayoutView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "명언 생성기"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    let colorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let quoteLabel: UILabel = {
        let label = UILabel()
        
        label.text = "명언 생성기 명언 생성기 명언 생성기 명언 생성기 명언 생성기 명언 생성기명언 생성기 명언 생성기명언 생성기명언 생성기 명언 생성기 명언 생성기 명언 생성기 명언 생성기 명언 생성기 명언 생성기 명언 생성기 명언 생성기 명언 생성기 명언 생성기 명언 생성기명언 생성기 명언 생성기명언 생성기명언 생성기 명언 생성기 명언 생성기 명언 생성기 명언 생성기 명언 생성기 "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "명언가"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    
    let quoteButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("명언 생성", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.addSubview(titleLabel)
        self.addSubview(colorView)
        self.addSubview(quoteButton)
        
        let safeArea = self.safeAreaLayoutGuide
        
        self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        
        self.colorView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 24).isActive = true
        self.colorView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        self.colorView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        self.colorView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        self.quoteButton.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 20).isActive = true
        self.quoteButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        
        // colorView constraints
        colorView.addSubview(quoteLabel)
        colorView.addSubview(nameLabel)
        
        self.quoteLabel.topAnchor.constraint(equalTo: colorView.topAnchor, constant: 20).isActive = true
        self.quoteLabel.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 20).isActive = true
        self.quoteLabel.trailingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: -20).isActive = true
        self.quoteLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.quoteLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        // 우선순위 설정
        self.nameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.nameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        self.nameLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 20).isActive = true
        self.nameLabel.bottomAnchor.constraint(equalTo: colorView.bottomAnchor, constant: -20).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 20).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: -20).isActive = true
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
