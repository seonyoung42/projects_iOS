//
//  SearchBookPresenter.swift
//  BookReview
//
//  Created by 장선영 on 2023/10/06.
//

import Foundation

protocol SearchBookProtocol {
    func setupViews()
}

final class SearchBookPresenter {
    
    private let viewController: SearchBookProtocol
    
    init(viewController: SearchBookProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupViews()
    }
}
