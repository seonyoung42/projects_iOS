//
//  SearchBookViewController.swift
//  BookReview
//
//  Created by 장선영 on 2023/10/06.
//

import UIKit
import SnapKit

final class SearchBookViewController: UIViewController {
    
    private lazy var presenter = SearchBookPresenter(viewController: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension SearchBookViewController: SearchBookProtocol {
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        navigationItem.searchController = searchController
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func dismiss() {
        dismiss(animated: true)
    }
}
