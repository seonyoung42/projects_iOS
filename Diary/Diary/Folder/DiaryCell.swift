//
//  DiaryCell.swift
//  Diary
//
//  Created by 장선영 on 2022/01/03.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "label"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = "20.09.03(토)"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(dateLabel)
                
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        
        titleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        dateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        contentView.layer.cornerRadius = 3.0
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


