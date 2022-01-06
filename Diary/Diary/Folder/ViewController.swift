//
//  ViewController.swift
//  Diary
//
//  Created by 장선영 on 2022/01/03.
//

import UIKit

class FolderViewController: UIViewController {
    
    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(DiaryCell.self, forCellWithReuseIdentifier: "DiaryCell")
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private var diaryList = [Diary]() {
        didSet {
            self.saveDiary()
        }
    }


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

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushDiaryViewController))

        loadDiary()
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: Notification.Name("editDiary"), object: nil)
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else { return }
        guard let row = notification.userInfo?["indexPath.row"] as? Int else { return }
        
//        self.diaryList.remove(at: row)
//        self.diaryList.insert(diary, at: row)
        
        self.diaryList[row] = diary
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        
        self.collectionView.reloadData()
    }
    
    @objc func pushDiaryViewController() {
        let writeDiaryVC = WriteDiaryViewController()
        writeDiaryVC.delegate = self
        navigationController?.pushViewController(writeDiaryVC, animated: true)
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    private func saveDiary() {
        let defaults = UserDefaults.standard
        
        let diaryList = self.diaryList.map {
            ["title": $0.title,
             "content": $0.content,
             "date": $0.date,
             "isStar": $0.isStar
            ]
        }
        
        defaults.set(diaryList, forKey: "diaryList")
    }
    
    private func loadDiary() {
        
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: "diaryList") as? [[String: Any]] else { return }
        self.diaryList = data.compactMap({
            guard let title = $0["title"] as? String else { return nil }
            guard let content = $0["content"] as? String else { return nil }
            guard let date = $0["date"] as? Date else { return nil }
            guard let isStar = $0["isStar"] as? Bool else { return nil}
            
            return  Diary(title: title, content: content, date: date, isStar: isStar)
        })
        
        self.diaryList = self.diaryList.sorted(by: {$0.date > $1.date})
    }
}

extension FolderViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else { return UICollectionViewCell() }
        
        let diary = self.diaryList[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = self.dateToString(date: diary.date)
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.diaryList.count
    }
    
}




extension FolderViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = DiaryDetailViewController()
        viewController.diary = diaryList[indexPath.row]
        viewController.indexPath = indexPath
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension FolderViewController: WriteDiaryViewDelegate {
    func didSelectRegister(diary: Diary) {
        self.diaryList.append(diary)
        
        self.diaryList = self.diaryList.sorted(by: {$0.date > $1.date})
//        self.diaryList = self.diaryList.sorted(by: {
//            $0.date.compare($1.date) == .orderedDescending
//        })
        
        self.collectionView.reloadData()
    }
}

extension FolderViewController: DiaryDetailViewDelegate {
    func didSelectDelete(indexpath: IndexPath) {
        self.diaryList.remove(at: indexpath.row)
        self.collectionView.deleteItems(at: [indexpath])
    }
    
    func didSelectStar(indexPath: IndexPath, isStar: Bool) {
        self.diaryList[indexPath.row].isStar = isStar
    }
}
