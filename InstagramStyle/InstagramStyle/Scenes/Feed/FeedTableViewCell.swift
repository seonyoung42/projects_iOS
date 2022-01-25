//
//  FeedTableViewCell.swift
//  InstagramStyle
//
//  Created by 장선영 on 2022/01/25.
//

import UIKit
import SnapKit


// sfsymbol을 사용하는 경우 button의 이미지 크기를 원하는 대로 조정하지 못하는 이슈

extension UIButton {
    func setImage(systemName: String) {
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = .zero
        
        setImage(UIImage(systemName: systemName), for: .normal)
    }
}

final class FeedTableViewCell: UITableViewCell {
    
    let feedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        return imageView
    }()
    
    
    
    let heartButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(systemName: "heart")
        return button
    }()
    
    
    
    let messageButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "message")
        return button
    }()
    
    let paperplaneButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "paperplane")

        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(systemName: "bookmark")
        return button
    }()
    
    let buttonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        return stackView
    }()
    
    let likeCountedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 5
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 11, weight: .medium)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
        setCellLayout()
        feedImageView.backgroundColor = .tertiaryLabel
        likeCountedLabel.text = "000님 외 32명이 좋아합니다."
        contentLabel.text = "Instagram feed cell"
        dateLabel.text = "1일 전"
    }

}

private extension FeedTableViewCell {
    func setCellLayout() {
        [
            feedImageView,
            buttonStack,
            bookmarkButton,
            contentLabel,
            likeCountedLabel,
            dateLabel
        ].forEach {
            addSubview($0)
        }
        
        feedImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(feedImageView.snp.width)
        }
        

        [heartButton,messageButton,paperplaneButton].forEach {
            buttonStack.addArrangedSubview($0)
        }
        
        let buttonWidth: CGFloat = 24
        
        [heartButton,messageButton,paperplaneButton,bookmarkButton].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(buttonWidth)
                $0.height.equalTo(buttonWidth)
            }
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(feedImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.equalTo(buttonStack)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        likeCountedLabel.snp.makeConstraints {
            $0.top.equalTo(buttonStack.snp.bottom).offset(14)
            $0.leading.equalTo(buttonStack)
            $0.trailing.equalTo(bookmarkButton)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(likeCountedLabel.snp.bottom).offset(8)
            $0.leading.equalTo(buttonStack)
            $0.trailing.equalTo(bookmarkButton)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(8)
            $0.leading.equalTo(buttonStack)
            $0.trailing.equalTo(bookmarkButton)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
