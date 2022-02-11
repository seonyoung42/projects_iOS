//
//  Repository.swift
//  GithubStyle
//
//  Created by 장선영 on 2022/02/11.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    let name: String
    let description: String
    let stargazerCount: Int
    let language: String
    
    enum CodingKeyse: String, CodingKey {
        case id, name, description, language
        case stargazerCount = "stargazers_count"
    }
}
