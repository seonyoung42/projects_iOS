//
//  ReviewWritePresenter.swift
//  BookReview
//
//  Created by 장선영 on 2023/10/06.
//

import Foundation

protocol ReviewWriteProtocol {
    func setupNavigationBar()
    func setupView()
    func showCloseAlertController()
    func close()
}

final class ReviewWritePresenter {
    private let viewController: ReviewWriteProtocol
    
    init(viewController: ReviewWriteProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupView()
    }
    
    func didTapLeftBarButton() {
        viewController.showCloseAlertController()
    }
    
    func didTapRightBarButton() {
        viewController.close()
    }
}
