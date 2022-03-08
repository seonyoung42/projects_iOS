//
//  KLDocument.swift
//  FindConvenientStore
//
//  Created by 장선영 on 2022/03/08.
//

import Foundation

struct KLDocument: Decodable {
    let placeName: String
    let address: String
    let roadAddress: String
    let x: String
    let y: String
    let distance: String
    
    enum CodingKeys: String, CodingKey {
        case x,y,distance
        case placeName = "place_name"
        case address = "address_name"
        case roadAddress = "road_address_name"
    }
}
