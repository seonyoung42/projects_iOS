//
//  ContentCollectionViewRankCell.swift
//  NetflixStyleApp
//
//  Created by 장선영 on 2022/01/18.
//

import UIKit
import SnapKit

class ContentCollectionViewRankCell: UICollectionViewCell {
    let imageView = UIImageView()
    let label = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        label.font = .systemFont(ofSize: 100, weight: .black)
        label.textColor = .white
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(25)
        }
    }
}
