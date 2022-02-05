//
//  FeedViewController.swift
//  InstagramStyle
//
//  Created by 장선영 on 2022/01/25.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        // tableview를 collectionview처럼 사용하기 위해서 separator 없앰
        tableView.separatorStyle = .none
        
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedTableViewCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        
        setNavigationBar()
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setNavigationBar() {
        navigationItem.title = "Instagram"
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(tapRightBarButton))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func tapRightBarButton() {
        let imagepicker = UIImagePickerController()
        imagepicker.allowsEditing = true
        imagepicker.sourceType = .photoLibrary
        imagepicker.delegate = self
        present(imagepicker, animated: true, completion: nil)
    }

}

//tableview datasource, delegate
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setupCell()
        return cell
    }
}

//imagepicker delegate
extension FeedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImage: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = originImage
        }
        
        picker.dismiss(animated: true) { [weak self] in
            let nextVC = UploadPostViewController()
            nextVC.uploadImage = selectedImage
            self?.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
