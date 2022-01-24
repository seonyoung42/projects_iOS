//
//  RankingFeatureCollectionViewCell.swift
//  AppstoreStyle
//
//  Created by 장선영 on 2022/01/23.
//

import UIKit
import SnapKit
import Kingfisher

class RankingFeatureCollectionViewCell: UICollectionViewCell {
    
    static var height: CGFloat { 70.0}
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 7.0
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
//        label.text = "오이마켓"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
//        label.text = "집에서 잠자고 있는 물건들을 꺼내볼가요?"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor.secondaryLabel
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.setTitle("받기", for: .normal)
        button.layer.cornerRadius = 12.0
        button.backgroundColor = .secondarySystemBackground
        
        return button
    }()
    
    private lazy var descriptionLabel2: UILabel = {
        let label = UILabel()
        label.text = "앱 내 구입"
        label.isHidden = true
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()

    func setup(_ item: RankingFeature){
        setupLayout()
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        descriptionLabel2.isHidden = !item.isInPurchaseApp
    }
}

private extension RankingFeatureCollectionViewCell {
    func setupLayout() {
        [imageView,titleLabel,descriptionLabel,button,descriptionLabel2].forEach {
            contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.equalToSuperview()
            $0.width.equalTo(imageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        button.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(24)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        descriptionLabel2.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(4)
            $0.centerX.equalTo(button)
        }
    }
}
