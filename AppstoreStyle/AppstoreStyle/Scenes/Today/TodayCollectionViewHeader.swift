//
//  TodayCollectionViewHeader.swift
//  AppstoreStyle
//
//  Created by 장선영 on 2022/01/22.
//

import UIKit
import SnapKit

class TodayCollectionViewHeader: UICollectionReusableView {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
    
    let todayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36, weight: .black)
        return label
    }()
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        addSubview(dateLabel)
        addSubview(todayLabel)
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(16)
        }
        
        todayLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
            $0.leading.equalTo(dateLabel)
        }
    }
    
    func configureHeader() {
        dateLabel.text = "1월 22일 토요일"
        todayLabel.text = "투데이"
    }
}
