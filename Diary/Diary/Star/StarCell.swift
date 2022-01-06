//
//  StarCell.swift
//  Diary
//
//  Created by 장선영 on 2022/01/03.
//

import UIKit

class StarCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        titleLabel.backgroundColor = .blue
        dateLabel.backgroundColor = .blue
        
        contentView.layer.cornerRadius = 3
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
