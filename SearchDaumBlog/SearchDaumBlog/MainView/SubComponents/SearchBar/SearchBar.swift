//
//  SearchBar.swift
//  SearchDaumBlog
//
//  Created by 장선영 on 2022/02/15.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    
    let searchButton = UIButton()
    
    // SearchBar 버튼 탭 이베트
    // (UI event이기 때문에 PublishSubject대신 error를 방출하지 않는 PublishReplay사용)
    let searhButtonTapped = PublishRelay<Void>()
    
    // SearchBar 외부(MainViewController)로 내보낼 이벤트
    // (text)
    var shouldLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private func bind() {
        /*
         seachBar의 버튼 탭 이벤트
         1.SearchBar의 search button(keyboard의 searchButton) tapped
         2.button tapped
         -> combining operator(merge)를 사용해서 두 가지 경우 모두를 다를 수 있게 함
         */
        
        Observable
            .merge(
                /*
                 1.searchBar가 가지고 있는 rxcocoa가 지원하는 searchButtonclicked 이벤트
                   1-1. controlEvent<void>이기 때문에 asobservable()로 타입변환함
                 2. searchButton의 rxcocoa가 지원하는 tap
                   2-1. controlEvent<void>이기 때문에 asobservable()로 타입변환함
                 */
                self.rx.searchButtonClicked.asObservable(),
                searchButton.rx.tap.asObservable()
            )
            /*
             searchButtonTapped(PublishReplay)에 위 두 가지 obsdrvable을 bind 해주면
             위의 두 가지 Observable이 이벤트를 발생할 때마다
             해당 이벤트가 searchButonTapped로 binding되어 해당 subject가 이벤트를 가질 수 있음
             */
            .bind(to: searhButtonTapped)
            .disposed(by: disposeBag)
        
        /*
         searchButtonTapped는 어떠한 상황을 발생시켜야할까?
         1. endEditing(키보드 내려감)
         */
        
        searhButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
        
        /*
         searchButtonTapped가 shouldLoadResult의 trigger
         - searchButtonTapped의 가장 최신의 searchBar text를 전달
         - filter 연산자 : 빈 값인 경우 전달하지 않음
         - distinctuntilChanged : 중복값을 전달하지 않음
         */
        
        self.shouldLoadResult = searhButtonTapped
            .withLatestFrom(self.rx.text) { $1 ?? "" }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }
    
    
    private func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    
    private func layout() {
        addSubview(searchButton)

        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
        
    }
}


// MARK : endEditing cutom
extension Reactive where Base: SearchBar {
    var endEditing: Binder<Void> {
        // base = searchBar
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
