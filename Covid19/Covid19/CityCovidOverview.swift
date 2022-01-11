//
//  CityCovidOverview.swift
//  Covid19
//
//  Created by 장선영 on 2022/01/10.
//

import Foundation

struct CityCovidOverview: Codable {
    
    let korea: CityOverview
    let seoul: CityOverview
    let busan: CityOverview
    let daegu: CityOverview
    let incheon: CityOverview
    let gwangju: CityOverview
    let daejeon: CityOverview
    let ulsan: CityOverview
    let sejong: CityOverview
    let gyeonggi: CityOverview
    let gangwon: CityOverview
    let chungbuk: CityOverview
    let chungnam: CityOverview
    let jeonbuk: CityOverview
    let jeonnam: CityOverview
    let gyeongbuk: CityOverview
    let gyeongnam: CityOverview
    let jeju: CityOverview
    
}


struct CityOverview: Codable {
    let countryName: String
    let newCase: String
    let totalCase: String
    let recovered: String
    let death: String
    let percentage: String
    let newCcase: String
    let newFcase: String
}
