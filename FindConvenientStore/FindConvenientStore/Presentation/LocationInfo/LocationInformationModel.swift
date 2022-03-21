//
//  LocationInformationModel.swift
//  FindConvenientStore
//
//  Created by 장선영 on 2022/03/21.
//

import Foundation
import RxSwift

struct LocationInfromationModel {
    let localNetwork: LocalNetwork
    
    init(localNetwork: LocalNetwork = LocalNetwork()) {
        self.localNetwork = localNetwork
    }
    
    func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        return localNetwork.getLocaion(by: mapPoint)
    }
    
    func documentsToCellData(_ data: [KLDocument]) -> [DetailListCellData] {
        return data.map {
            let address = $0.roadAddress.isEmpty ? $0.address : $0.roadAddress
            let point = documentToMTMapPoint($0)
            return DetailListCellData(placeName: $0.placeName, address: address, distance: $0.distance, point: point)
        }
    }
    
    func documentToMTMapPoint(_ doc: KLDocument) -> MTMapPoint {
        let latitude = Double(doc.x) ?? .zero
        let longitude = Double(doc.y) ?? .zero
        return MTMapPoint(geoCoord: MTMapPointGeo(latitude: latitude, longitude: longitude))
    }
}
