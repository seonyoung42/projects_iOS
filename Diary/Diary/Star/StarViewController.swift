//
//  SecondViewController.swift
//  Diary
//
//  Created by 장선영 on 2022/01/03.
//

import UIKit

class StarViewController: UIViewController {
    
    private var diaryList = [Diary]()
    
    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 80)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.register(StarCell.self, forCellWithReuseIdentifier: "StarCell")

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.view.addSubview(collectionView)
        
        let safeArea = self.view.safeAreaLayoutGuide

        collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadStarDiary()
    }
    
    private func loadStarDiary() {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: "diaryList") as? [[String: Any]] else { return }
        
        self.diaryList = data.compactMap({
            guard let title = $0["title"] as? String else { return nil}
            guard let content = $0["content"] as? String else { return nil}
            guard let date = $0["date"] as? Date else { return nil }
            guard let isStar = $0["isStar"] as? Bool else { return nil }
            return Diary(title: title, content: content, date: date, isStar: isStar)
        }).filter({
            $0.isStar == true
        }).sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        
        self.collectionView.reloadData()
    }
    
}

extension StarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.diaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarCell", for: indexPath) as? StarCell else { return UICollectionViewCell()}
        
        let diary = self.diaryList[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = self.dateToString(diary.date)
        
        return cell
    }
    
    func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

extension StarViewController: UICollectionViewDelegate {
    
}
