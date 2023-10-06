//
//  ReviewWriteViewController.swift
//  BookReview
//
//  Created by 장선영 on 2023/10/06.
//

import UIKit

final class ReviewWriteViewController: UIViewController {
    
    private lazy var presenter = ReviewWritePresenter(viewController: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
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
}

private extension ReviewWriteViewController {
    @objc func didTapLeftBarButton() {
        presenter.didTapLeftBarButton()
    }
    
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton()
    }
}
