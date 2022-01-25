//
//  RealtimeArrivalModel.swift
//  Subway
//
//  Created by 장선영 on 2022/01/24.
//

import Foundation
//
struct RealtimeArrivalModel: Decodable {
    let realtimeArrivalList: [RealtimeArrival]
}

struct RealtimeArrival: Decodable {
    let lineName: String
    let remainTime: String
    let currentStation: String

    enum CodingKeys: String, CodingKey {
        case lineName = "trainLineNm"
        case remainTime = "arvlMsg2"
        case currentStation = "arvlMsg3"
    }
}
//
//struct RealtimeArrivalModel: Decodable {
//    var realtimeArrivalList: [RealtimeArrival] = []
//
//    struct RealtimeArrival: Decodable {
//        let lineName: String
//        let remainTime: String
//        let currentStation: String
//
//        enum CodingKeys: String, CodingKey {
//            case lineName = "trainLineNm"
//            case remainTime = "arvlMsg2"
//            case currentStation = "arvlMsg3"
//        }
//    }
//}
//
//
