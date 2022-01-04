//
//  ViewController.swift
//  Diary
//
//  Created by 장선영 on 2022/01/03.
//

import UIKit

class FolderViewController: UIViewController {
    
//    var collectionView : UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//
//        layout.scrollDirection = .vertical
//
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.backgroundColor = .yellow
//        collectionView.register(DiaryCell.self, forCellWithReuseIdentifier: "DiaryCell")
//
//        return collectionView
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
//        self.view.addSubview(collectionView)
//        let safeArea = self.view.safeAreaLayoutGuide
//
//        collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
}

