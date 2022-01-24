//
//  RankingFeatureSectionView.swift
//  AppstoreStyle
//
//  Created by 장선영 on 2022/01/23.
//

import UIKit
import SnapKit

final class RankingFeatureSectionView: UIView {
    
    var rankingFeatureList = [RankingFeature]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.text = "iPhone이 처음이라면"
        return label
    }()
    
    private lazy var allButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("모두 보기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let width = UIScreen.main.bounds.width - 32
        layout.itemSize = CGSize(width: width, height: RankingFeatureCollectionViewCell.height)

        let insetValue: CGFloat = 16.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: insetValue, bottom: 0.0, right: insetValue)

        layout.minimumLineSpacing = 32
        layout.minimumInteritemSpacing = 0.0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(RankingFeatureCollectionViewCell.self, forCellWithReuseIdentifier: "RankingFeatureCollectionViewCell")
        return collectionView
    }()
    
    private let separatorView = SeparatorView(frame: .zero)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        getData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RankingFeatureSectionView {
    func setupLayout() {
        
        [titleLabel, allButton,collectionView, separatorView]
            .forEach { addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(16)
            $0.trailing.equalTo(allButton.snp.leading).offset(8)
        }

        allButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(titleLabel.snp.bottom)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(RankingFeatureCollectionViewCell.height * 3)
        }

        separatorView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension RankingFeatureSectionView : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rankingFeatureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingFeatureCollectionViewCell", for: indexPath) as? RankingFeatureCollectionViewCell else { return UICollectionViewCell()}
        
        let item = rankingFeatureList[indexPath.item]
        cell.setup(item)
        
        return cell
    }
}

// get Data
private extension RankingFeatureSectionView {
    func getData() {
        guard let url = Bundle.main.url(forResource: "RankingFeature", withExtension: "plist") else { return }
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([RankingFeature].self, from: data)
            rankingFeatureList = result
        } catch {
            
        }
    }
}
