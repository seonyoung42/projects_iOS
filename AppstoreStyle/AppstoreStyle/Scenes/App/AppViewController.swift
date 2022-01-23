//
//  AppViewController.swift
//  AppstoreStyle
//
//  Created by 장선영 on 2022/01/22.
//

import UIKit

class AppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "앱"

    }
}
