//
//  Feature.swift
//  AppstoreStyle
//
//  Created by 장선영 on 2022/01/24.
//

import Foundation

struct Feature:Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
