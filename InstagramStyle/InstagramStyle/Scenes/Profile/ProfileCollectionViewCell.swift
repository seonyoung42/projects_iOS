//
//  ProfileCollectionViewCell.swift
//  InstagramStyle
//
//  Created by 장선영 on 2022/01/25.
//

import UIKit
import SnapKit

final class ProfileCollectionViewCell: UICollectionViewCell {
    
    private lazy var profileFeedImageView: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
    func setupCell() {
        setupCellLayout()
        profileFeedImageView.backgroundColor = .lightGray
    }
}

private extension ProfileCollectionViewCell {
    func setupCellLayout() {
        addSubview(profileFeedImageView)
        
        profileFeedImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
