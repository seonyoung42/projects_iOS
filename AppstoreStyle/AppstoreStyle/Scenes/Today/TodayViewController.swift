//
//  TodayViewController.swift
//  AppstoreStyle
//
//  Created by 장선영 on 2022/01/22.
//

import UIKit
import SnapKit

class TodayViewController: UIViewController {
    
    private var todayList = [Today]()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let width = UIScreen.main.bounds.width - 32
        layout.itemSize = CGSize(width: width, height: width)
        layout.headerReferenceSize = CGSize(width: width, height: 100)
        let value: CGFloat = 16.0
        layout.sectionInset = .init(top: value, left: value, bottom: value, right: value)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        
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
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        getData()
    }
}


// collectionView Datasource, delegate
extension TodayViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        todayList.count
    }
    
    // cell 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCollectionViewCell", for: indexPath) as? TodayCollectionViewCell else { return UICollectionViewCell() }
        let today = todayList[indexPath.item]
        
        cell.configureCell(today)
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let today = todayList[indexPath.item]
        let detailVC = AppDetailViewController()
        detailVC.app = today
        self.present(detailVC, animated: true, completion: nil)
    }
    
}


// fetch Data from plist
private extension TodayViewController {
    func getData() {
        guard let url = Bundle.main.url(forResource: "Today", withExtension: "plist") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Today].self,from: data)
            self.todayList = result
        } catch {
            
        }
    }
}
