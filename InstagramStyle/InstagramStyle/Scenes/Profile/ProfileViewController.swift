//
//  ProfileViewController.swift
//  InstagramStyle
//
//  Created by 장선영 on 2022/01/25.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "user name"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "반갑습니다"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("팔로우", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 3
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        return button
    }()
    
    private lazy var messageButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("메시지", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        button.layer.borderWidth = 0.5

        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width:CGFloat = (UIScreen.main.bounds.width/3 - 1.0)
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 0.5

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        return collectionView
    }()
    
    private let photoDataView = ProfileDataView(title: "게시물", count: 123)
    private let followerDataView = ProfileDataView(title: "팔로워", count: 2222)
    private let followingDataView = ProfileDataView(title: "팔로잉", count: 22)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setNavigationBar()
        setLayout()
    }
}

// collectionView datasource, delegate
extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell()
        return cell
    }
}



private extension ProfileViewController {
    
    func setNavigationBar() {
        navigationItem.title = "userName"
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(tapRightBarButton))
        navigationItem.rightBarButtonItem = rightBarButton
    }

    @objc private func tapRightBarButton() {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let modify = UIAlertAction(title: "회원 정보 변경", style: .default, handler: nil)
        let remove = UIAlertAction(title: "탈퇴하기", style: .destructive, handler: nil)
        let close = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        
        [modify,remove,close].forEach {
            ac.addAction($0)
        }
        
        present(ac, animated: true, completion: nil)
    }
    
    func setLayout() {
        let buttonStackView = UIStackView(arrangedSubviews: [followButton,messageButton])
        buttonStackView.spacing = 4
        buttonStackView.distribution = .fillEqually
        
        let dataStackView = UIStackView(arrangedSubviews: [photoDataView,followerDataView,followingDataView])
        dataStackView.spacing = 4
        dataStackView.distribution = .fillEqually
        
        [profileImageView,
         nameLabel,
         descriptionLabel,
         buttonStackView,
         dataStackView,
         collectionView
        ].forEach {
            view.addSubview($0)
        }
        
        let inset: CGFloat = 16.0
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.width.equalTo(80)
            $0.height.equalTo(profileImageView.snp.width)
        }
        
        dataStackView.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(12)
            $0.leading.equalTo(profileImageView)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalTo(nameLabel)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(nameLabel)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(buttonStackView.snp.bottom).offset(10)
        }
    }
}
