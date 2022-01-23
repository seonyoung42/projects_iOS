//
//  TodayViewController.swift
//  AppstoreStyle
//
//  Created by 장선영 on 2022/01/22.
//

import UIKit
import SnapKit

class TodayViewController: UIViewController {
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let width = UIScreen.main.bounds.width - 32
        layout.itemSize = CGSize(width: width, height: width)
        layout.headerReferenceSize = CGSize(width: width, height: 100)
        let value: CGFloat = 16.0
        layout.sectionInset = .init(top: value, left: value, bottom: value, right: value)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        //cell 등록
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: "TodayCollectionViewCell")
        //header 등록
        collectionView.register(TodayCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TodayCollectionViewHeader")
        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(collectionView)
//        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


// collectionView Datasource, delegate
extension TodayViewController: UICollectionViewDataSource {
    
    // cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    // cell 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCollectionViewCell", for: indexPath) as? TodayCollectionViewCell else { return UICollectionViewCell() }

        cell.configureCell()
        
        return cell
    }
    
    //headerView 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodayCollectionViewHeader", for: indexPath) as? TodayCollectionViewHeader else { return UICollectionReusableView()}
            
            headerView.configureHeader()
           
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
}

