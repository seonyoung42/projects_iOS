//
//  StationDetailCollectionViewCell.swift
//  Subway
//
//  Created by 장선영 on 2022/01/24.
//

import UIKit
import SnapKit

class StationDetailCollectionViewCell: UICollectionViewCell {
    private let lineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [lineLabel,detailLabel].forEach {
            contentView.addSubview($0)
        }
        
        lineLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        detailLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(lineLabel)
            $0.top.equalTo(lineLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func setup(_ item: RealtimeArrival) {
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 10
        
        contentView.backgroundColor = .systemBackground

//        lineLabel.text = "왕십리행 - 왕십리방면"
//        detailLabel.text = "왕십리 도착"
        
        lineLabel.text = item.lineName
        detailLabel.text = item.remainTime
    }
}
