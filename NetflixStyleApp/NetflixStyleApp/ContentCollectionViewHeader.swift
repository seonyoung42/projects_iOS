//
//  ContentCollectionViewHeader.swift
//  NetflixStyleApp
//
//  Created by 장선영 on 2022/01/18.
//

import UIKit

class ContentCollectionViewHeader: UICollectionReusableView {
    let sectionLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionLabel.textColor = .white
        sectionLabel.sizeToFit()
        
        addSubview(sectionLabel)
        
        sectionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
}
