//
//  DetailWriteFormCellViewModel.swift
//  UsedGoodsUpload
//
//  Created by 장선영 on 2022/02/23.
//

import RxSwift
import RxCocoa

struct DetailWriteFormCellViewModel {
    //view -> viewModel (작성한 text)
    let contentValue = PublishRelay<String?>()
}
