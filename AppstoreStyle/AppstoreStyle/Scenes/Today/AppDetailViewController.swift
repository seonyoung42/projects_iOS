//
//  AppDetailViewController.swift
//  AppstoreStyle
//
//  Created by 장선영 on 2022/01/24.
//
import SnapKit
import UIKit
import Kingfisher

class AppDetailViewController: UIViewController {
    
    var app:Today?
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
   
    let downloadButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
//        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.layer.cornerRadius = 12
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapShareButton() {
        guard let today = app else { return }
        let activityItems: [Any] = [today.title]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        [descriptionLabel,titleLabel,imageView,downloadButton,shareButton].forEach {
            self.view.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(100)
            $0.width.equalTo(imageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(titleLabel)
        }
        
        downloadButton.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(32)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
        
        shareButton.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(shareButton.snp.width)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
        
        configureView()
    }
    
    func configureView() {
        guard let today = app else { return }
        titleLabel.text = today.title
        descriptionLabel.text = today.description
        
        if let url = URL(string: today.imageURL) {
            imageView.kf.setImage(with: url)
        }
    }
}
