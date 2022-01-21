//
//  File.swift
//  Brewery
//
//  Created by 장선영 on 2022/01/20.
//

import Foundation

struct Beer: Decodable {
    let id: Int?
    let name, tagLineString, description, brewersTips, imageURL: String?
    let foodPairing: [String]?
    
    var tagLine: String {
        let tags = tagLineString?.components(separatedBy: ". ")
        let hashTags = tags?.map {
            "#" + $0.replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: ",", with: "")
        }
        
        return hashTags?.joined(separator: "  ") ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case tagLineString = "tagline"
        case imageURL = "image_url"
        case brewersTips = "brewers_tips"
        case foodPairing = "food_pairing"
    }
}
