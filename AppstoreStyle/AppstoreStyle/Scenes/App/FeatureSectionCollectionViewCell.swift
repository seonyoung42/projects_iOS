//
//  FeatureSectionCollectionViewCell.swift
//  AppstoreStyle
//
//  Created by 장선영 on 2022/01/23.
//

import UIKit
import SnapKit

final class FeatureSectionCollectionViewCell: UICollectionViewCell {
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 7.0
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    func setup() {
        setupLayout()
        
        typeLabel.text = "type"
        appNameLabel.text = "App name"
        descriptionLabel.text = "description"
        imageView.backgroundColor = .lightGray
    }
}

private extension FeatureSectionCollectionViewCell {
    func setupLayout() {
        [typeLabel,appNameLabel,descriptionLabel,imageView].forEach {
            contentView.addSubview($0)
        }
        
        typeLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        appNameLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(appNameLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
