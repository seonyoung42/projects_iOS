//
//  LocalNetworkStub.swift
//  FindConvenientStoreTests
//
//  Created by 장선영 on 2022/03/29.
//

import Foundation
import RxSwift
import Stubber

@testable import FindConvenientStore

class LocalNetworkStub: LocalNetwork {
    override func getLocaion(by mapPoint: MTMapPoint) -> Single<Result<LocationData,URLError>> {
        return Stubber.invoke(getLocaion, args:mapPoint)
    }
}
