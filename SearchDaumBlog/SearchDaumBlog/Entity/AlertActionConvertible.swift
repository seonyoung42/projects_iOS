//
//  AlertActionConvertible.swift
//  SearchDaumBlog
//
//  Created by 장선영 on 2022/02/18.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
