//
//  SeparatorView.swift
//  AppstoreStyle
//
//  Created by 장선영 on 2022/01/23.
//

import UIKit
import SnapKit

final class SeparatorView: UIView {
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .separator
        return separator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(separator)
        
        separator.snp.makeConstraints {
            $0.height.equalTo(0.6)
            $0.top.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
