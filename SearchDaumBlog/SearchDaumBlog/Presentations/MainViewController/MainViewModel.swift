//
//  MainViewModel.swift
//  SearchDaumBlog
//
//  Created by 장선영 on 2022/02/22.
//

import RxSwift
import RxCocoa
import Foundation

struct MainViewModel {
    let disposeBag = DisposeBag()
    let blogListViewModel = BlogListViewModel()
    let searchBarViewModel = SearchBarViewModel()
    
    let alertActionTapped = PublishRelay<MainViewController.AlertAction>()
    let shouldPresentAlert: Signal<MainViewController.Alert>
    
    init(model: MainModel = MainModel()) {
        let blogResult = searchBarViewModel.shouldLoadResult
            .flatMapLatest(model.searchBlog(_:))
            .share()
        
        let blogValue = blogResult
            .compactMap(model.getBlogValue)
        
        let blogError = blogResult
            .compactMap(model.getBlogError)
        
        // network 로 받은 데이터를 cellData로 변환
        let cellData = blogValue
            .compactMap(model.getBlogListCellData(_:))
                
        // filterview를 선택했을 때 나오는 alertsheet 선택 시 type
        let sortedType = alertActionTapped
            .filter {
                switch $0 {
                case .title, .dateTime:
                    return true
                default:
                    return false
                }
            }
            .startWith(.title)
        
        // MainVC -> ListView로 cellData 전달
        Observable
            .combineLatest(sortedType, cellData, resultSelector: model.sort)
            .bind(to: blogListViewModel.blogCellData)
            .disposed(by: disposeBag)
        
        
        let alertSheetForSorting = blogListViewModel
            .filterViewModel
            .sortButtonTapped
            .map { _ -> MainViewController.Alert in
                return (title: nil, message: nil, actions: [.title, .dateTime, .cancel], style: .actionSheet)
            }
        
        let alertForErrorMessage = blogError
            .map { message -> MainViewController.Alert in
                return (
                    title: "앗",
                    message: "예상치 못한 오류가 발생했습니다. 잠시후 다시 시도해주세요. \(message)",
                    actions: [.confirm],
                    style: .alert
                )
            }
        
        self.shouldPresentAlert = Observable
            .merge(alertSheetForSorting,alertForErrorMessage)
            .asSignal(onErrorSignalWith: .empty())
    }
}
