//
//  ExchangeCodeButtonView.swift
//  AppstoreStyle
//
//  Created by 장선영 on 2022/01/23.
//

import UIKit
import SnapKit

final class ExchangeCodeButtonView: UIView {
    private lazy var exchangeButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("코드 교환", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.backgroundColor = .tertiarySystemGroupedBackground
        button.layer.cornerRadius = 7.0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(exchangeButton)
        
        exchangeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(32)
            $0.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
