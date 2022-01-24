//
//  TodayCollectionViewCell.swift
//  AppstoreStyle
//
//  Created by 장선영 on 2022/01/22.
//

import UIKit
import SnapKit
import Kingfisher

class TodayCollectionViewCell: UICollectionViewCell {
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let bottomLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        [descriptionLabel,titleLabel,bottomLabel].forEach {
            imageView.addSubview($0)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(descriptionLabel)
        }
        
        bottomLabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(24)
        }
        
    }
    
    func configureCell(_ today: Today) {
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowRadius = 10
        imageView.layer.cornerRadius = 12

        descriptionLabel.text = today.description
        titleLabel.text = today.title
        bottomLabel.text = today.subTitle
        
        if let url = URL(string: today.imageURL) {
            imageView.kf.setImage(with: url)
        }
    }
}
