//
//  WeatherInformation.swift
//  Weather
//
//  Created by 장선영 on 2022/01/09.
//

import Foundation

struct WeatherInformation: Codable {
    // codable = decodable + encodable (=> JSON을 인코딩, 디코딩 둘 다 가능하게 함)
    // weather API에서 받은 JSON 파일을 weatherInformation struct 타입으로 변환 (decoding)
    
    let weather: [Weather]
    let temp: Temp
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temp = "main"
        case name
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temp: Codable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    
    // Json 파일에 있더라도 사용하지 않는다면 정의해주지 않아도 됨
//    let pressure: Int
//    let humidity: Int
    
    // 구조체에서 정의해준 프로퍼티의 이름과 서버에서 제공하는 json파일의 프로퍼티 이름이 다른 경우 다음과 같이 설정
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
    
}
