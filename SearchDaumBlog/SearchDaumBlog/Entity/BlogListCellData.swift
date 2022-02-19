//
//  BlogListCellData.swift
//  SearchDaumBlog
//
//  Created by 장선영 on 2022/02/18.
//

import Foundation

struct BlogListCellData {
    // network이기에 값이 없을 수도 있으므로 optional 처리
    let thumbnailURL: URL?
    let name: String?
    let title: String?
    let datetime: Date?
}
