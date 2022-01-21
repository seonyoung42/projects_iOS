//
//  BeerListTableViewCell.swift
//  Brewery
//
//  Created by 장선영 on 2022/01/20.
//

import UIKit
import SnapKit
import Kingfisher

class BeerListTableViewCell: UITableViewCell {
    
    let beerImage = UIImageView()
    let beerNameLabel = UILabel()
    let tagLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [beerImage,beerNameLabel,tagLabel].forEach {
            contentView.addSubview($0)
        }
        
        beerImage.contentMode = .scaleAspectFit
        beerNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        beerNameLabel.numberOfLines = 2
        
        tagLabel.font = .systemFont(ofSize: 18, weight: .light)
        tagLabel.textColor = .systemBlue
        tagLabel.numberOfLines = 0
        
        beerImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(120)
        }
        
        beerNameLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImage.snp.trailing).offset(10)
            $0.bottom.equalTo(beerImage.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        tagLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(beerNameLabel)
            $0.top.equalTo(beerNameLabel.snp.bottom).offset(5)
        }
       
    }
    
    func configure(with beer: Beer) {
        let imageURL = URL(string: beer.imageURL ?? "")

        beerImage.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "images"))
        beerNameLabel.text = beer.name ?? "이름 없는 맥주"
        tagLabel.text = beer.tagLine
        
        accessoryType = .disclosureIndicator
        // cell 선택하여도 회색으로 선택 셀 배경 색상 변경되지 않음
        selectionStyle = .none
    }
}
