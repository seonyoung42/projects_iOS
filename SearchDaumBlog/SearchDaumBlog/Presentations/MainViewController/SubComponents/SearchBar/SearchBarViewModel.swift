//
//  SearchBarviewModel.swift
//  SearchDaumBlog
//
//  Created by 장선영 on 2022/02/22.
//

import RxSwift
import RxCocoa

struct SearchBarViewModel {
    let queryText = PublishRelay<String?>()
    let searhButtonTapped = PublishRelay<Void>()
    let shouldLoadResult : Observable<String>
    
    init() {
        self.shouldLoadResult = searhButtonTapped
            .withLatestFrom(queryText) { $1 ?? "" }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()

    }
}
