//
//  ViewController.swift
//  Translate
//
//  Created by 장선영 on 2022/05/22.
//

import UIKit

final class TabBarController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let translateViewController = TranslateViewController()
        translateViewController.tabBarItem = UITabBarItem(title: "Translate",
                                                          image: UIImage(systemName: "mic"),
                                                          selectedImage: UIImage(systemName: "mic.fill"))
        let bookMarkViewController = UIViewController()
        bookMarkViewController.tabBarItem = UITabBarItem(title: "즐겨찾기",
                                                         image: UIImage(systemName: "star"),
                                                         selectedImage: UIImage(systemName: "star.fill"))
        
        viewControllers = [translateViewController,bookMarkViewController]
    }
}

