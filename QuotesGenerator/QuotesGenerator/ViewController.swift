//
//  ViewController.swift
//  QuotesGenerator
//
//  Created by 장선영 on 2021/12/12.
//

import UIKit

class ViewController: UIViewController {
    private lazy var autoLayoutView = AutoLayoutView(frame: self.view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view = autoLayoutView
    }


}

