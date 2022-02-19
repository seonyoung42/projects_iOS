//
//  BlogListCell.swift
//  SearchDaumBlog
//
//  Created by 장선영 on 2022/02/18.
//

import UIKit
import SnapKit
import Kingfisher

class BlogListCell: UITableViewCell {
    let thumbnailImageview = UIImageView()
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        thumbnailImageview.contentMode = .scaleAspectFit
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.numberOfLines = 2
        dateLabel.font = .systemFont(ofSize: 12, weight: .light)
        
        [thumbnailImageview,nameLabel,titleLabel,dateLabel].forEach {
            contentView.addSubview($0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(8)
            $0.trailing.lessThanOrEqualTo(thumbnailImageview.snp.leading).offset(-8)
        }
        
        thumbnailImageview.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalTo(thumbnailImageview.snp.leading).offset(-8)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(titleLabel)
//            $0.bottom.equalTo(thumbnailImageview)
        }
    }
    
    func setData(_ data: BlogListCellData) {
        thumbnailImageview.kf.setImage(with: data.thumbnailURL, placeholder: UIImage(systemName: "photo"))
        nameLabel.text = data.name
        titleLabel.text = data.title
        
        var dateString: String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            return dateFormatter.string(from: data.datetime ?? Date())
        }
        
        dateLabel.text = dateString
    }
}
