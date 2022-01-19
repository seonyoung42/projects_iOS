//
//  ContentCollectionViewCell.swift
//  NetflixStyleApp
//
//  Created by 장선영 on 2022/01/18.
//

import UIKit
import SnapKit

class ContentCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleToFill
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            // contentView의 모든 edge에 맞게 
            $0.edges.equalToSuperview()
        }
        
    }
}
