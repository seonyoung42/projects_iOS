//
//  ContentCollectionViewMainCell.swift
//  NetflixStyleApp
//
//  Created by 장선영 on 2022/01/18.
//

import UIKit
import SnapKit

class ContentCollectionViewMainCell: UICollectionViewCell {
    
    let baseStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let menuStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let tvButton : UIButton = {
        let button = UIButton()
        button.setTitle("TV 프로그램", for: .normal)
        button.addTarget(self, action: #selector(tvButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let movieButton : UIButton = {
        let button = UIButton()
        button.setTitle("영화", for: .normal)
        button.addTarget(self, action: #selector(movieButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let categoryButton : UIButton = {
        let button = UIButton()
        button.setTitle("카테고리", for: .normal)
        button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let imageView = UIImageView()
    let descriptionLabel : UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
        return descriptionLabel
    }()
    
    let contentStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 5
        return stackView
    }()
    

    let plusButton : UIButton = {
        let button = UIButton()
        button.setTitle("내가 찜한 콘텐츠", for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let infoButton : UIButton = {
        let button = UIButton()
        button.setTitle("정보", for: .normal)
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.addTarget(self, action: #selector(infoButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let playButton : UIButton = {
        let button = UIButton()
        button.setTitle("재생", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 3
        
        button.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [baseStackView,menuStackView].forEach {
            contentView.addSubview($0)
        }
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        [imageView,descriptionLabel,contentStackView].forEach {
            baseStackView.addArrangedSubview($0)
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        contentStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        menuStackView.snp.makeConstraints {
            $0.top.equalTo(baseStackView.snp.top)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        [tvButton,movieButton,categoryButton].forEach {
            menuStackView.addArrangedSubview($0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 3
        }
        
        [plusButton, playButton, infoButton].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        [plusButton,infoButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 13)
            $0.setTitleColor(.white, for: .normal)
            $0.imageView?.tintColor = .white
            $0.adjustVerticalLayout(5)
        }
        
        playButton.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(30)
        }
    }
    
    @objc func tvButtonTapped(_ sender: UIButton) {
        print("TV Button Tapped")
    }
    
    @objc func movieButtonTapped(_ sender: UIButton) {
        print("Movie Button Tapped")
    }
    
    @objc func categoryButtonTapped(_ sender: UIButton) {
        print("Category Button Tapped")
    }
    
    @objc func plusButtonTapped(_ sender: UIButton) {
        print("Plus Button Tapped")
    }
    
    @objc func infoButtonTapped(_ sender: UIButton) {
        print("Info Button Tapped")
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        print("Play Button Tapped")
    }
}

