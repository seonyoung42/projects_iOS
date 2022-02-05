//
//  UploadPostViewController.swift
//  InstagramStyle
//
//  Created by 장선영 on 2022/01/25.
//

import UIKit
import SnapKit

class UploadPostViewController: UIViewController {
    
    var uploadImage: UIImage?
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var postTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 15)
        textView.text = "문구 입력 ..."
        textView.textColor = .secondaryLabel
        textView.delegate = self
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setNavigationBar()
        setupLayout()
    }
    
    // init메서드로 uploadImage 받아도 됨
//    init(uploadImage: UIImage) {
//        self.uploadImage = uploadImage
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

// textView delegate
extension UploadPostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        textView.text = nil
        textView.textColor = .label
    }
}

private extension UploadPostViewController {
    
    func setNavigationBar() {
        navigationItem.title = "새 게시물"
        
        let leftBarButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(tapCancelButton))
        let rightBarButton = UIBarButtonItem(title: "공유", style: .plain, target: self, action: #selector(tapShareButton))
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func tapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc func tapShareButton() {
        
    }
    
    func setupLayout() {
        [postImageView,postTextView].forEach { view.addSubview($0) }
        
        let inset: CGFloat = 15.0
        let width = 100
        
        postImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.width.equalTo(width)
            $0.height.equalTo(width)
        }
        
        postTextView.snp.makeConstraints {
            $0.leading.equalTo(postImageView.snp.trailing).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.top.bottom.equalTo(postImageView)
        }
        
        guard let image = uploadImage else { return }
        postImageView.image = image
    }
}
