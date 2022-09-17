//
//  PriceTaxFieldViewModel.swift
//  UsedGoodsUpload
//
//  Created by 장선영 on 2022/02/23.
//

import RxSwift
import RxCocoa

struct PriceTextFieldCellViewModel {
    // viewModel -> view
    let showFreeShareButton : Signal<Bool>
    let resetPrice : Signal<Void>
    
    //view -> viewModel
    let priceValue = PublishRelay<String>()
    let freeshareButtonTapped = PublishRelay<Void>()
    
    init() {
        self.showFreeShareButton = Observable
            .merge(
                priceValue.map { $0 ?? "" == "0"},
                freeshareButtonTapped.map { _ in false }
            )
            .asSignal(onErrorJustReturn: false)
        
        self.resetPrice = freeshareButtonTapped
            .asSignal(onErrorSignalWith: .empty())
    }
}
