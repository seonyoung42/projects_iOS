//
//  ReviewWriteViewController.swift
//  BookReview
//
//  Created by 장선영 on 2023/10/06.
//

import UIKit
import SnapKit

final class ReviewWriteViewController: UIViewController {
    
    private lazy var presenter = ReviewWritePresenter(viewController: self)
    
    private lazy var bookTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("책 제목", for: .normal)
        button.setTitleColor(.tertiaryLabel, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 23.0, weight: .bold)
        return button
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.text = "입력해주세요"
        textView.textColor = .tertiaryLabel
        textView.font = .systemFont(ofSize: 16.0, weight: .medium)
        textView.delegate = self
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ReviewWriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .tertiaryLabel else {
            return
        }
        
        textView.text = nil
        textView.textColor = .black
    }
}

extension ReviewWriteViewController: ReviewWriteProtocol {
    func setupNavigationBar() {
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                target: self,
                                                action: #selector(didTapLeftBarButton))
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                 target: self,
                                                 action: #selector(didTapRightBarButton))
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func showCloseAlertController() {
        let alertController = UIAlertController(title: "작성중인 내용이 있습니다. 정말 닫으시겠습니까?",
                                                message: nil,
                                                preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: "닫기", style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        [closeAction, cancelAction].forEach {
            alertController.addAction($0)
        }
        
        present(alertController, animated: true)
    }
    
    func close() {
        // TODO: 도서리뷰 저장하기
        dismiss(animated: true)
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        
        [bookTitleButton, contentTextView, imageView].forEach {
            view.addSubview($0)
        }
        
        bookTitleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
        }
        
        contentTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(bookTitleButton.snp.bottom).offset(16)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentTextView)
            $0.top.equalTo(contentTextView.snp.bottom).offset(16)
            $0.height.equalTo(200)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

private extension ReviewWriteViewController {
    @objc func didTapLeftBarButton() {
        presenter.didTapLeftBarButton()
    }
    
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton()
    }
}
