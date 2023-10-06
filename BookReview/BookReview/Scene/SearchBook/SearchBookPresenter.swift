//
//  SearchBookPresenter.swift
//  BookReview
//
//  Created by 장선영 on 2023/10/06.
//

import UIKit
import Foundation

protocol SearchBookProtocol {
    func setupViews()
    func dismiss()
}

final class SearchBookPresenter: NSObject {
    
    private let viewController: SearchBookProtocol
    
    init(viewController: SearchBookProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupViews()
    }
}

extension SearchBookPresenter: UISearchBarDelegate {
    
}

extension SearchBookPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController.dismiss()
    }
}

extension SearchBookPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath)"
        
        return cell
    }
}
