//
//  PriceTextFieldCell.swift
//  UsedGoodsUpload
//
//  Created by 장선영 on 2022/02/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PriceTextFieldCell: UITableViewCell {
    let disposebag = DisposeBag()
    let priceInputField = UITextField()
    let freeshareButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: PriceTextFieldCellViewModel) {
        viewModel.showFreeShareButton
            .map {!$0}
            .emit(to: freeshareButton.rx.isHidden)
            .disposed(by: disposebag)
        
        viewModel.resetPrice
            .map { _ in "" }
            .emit(to: priceInputField.rx.text)
            .disposed(by: disposebag)
        
        priceInputField.rx.text
            .bind(to: viewModel.priceValue)
            .disposed(by: disposebag)
        
        freeshareButton.rx.tap
            .bind(to: viewModel.freeshareButtonTapped)
            .disposed(by: disposebag)
    }
    
    private func attribute() {
        freeshareButton.setTitle("무료나눔", for: .normal)
        freeshareButton.setTitleColor(.orange, for: .normal)
        freeshareButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        freeshareButton.titleLabel?.font = .systemFont(ofSize: 18)
        freeshareButton.tintColor = .orange
        freeshareButton.backgroundColor = .white
        freeshareButton.layer.borderColor = UIColor.orange.cgColor
        freeshareButton.layer.borderWidth = 1.0
        freeshareButton.layer.cornerRadius = 10.0
        freeshareButton.clipsToBounds = true
        freeshareButton.isHidden = true
        freeshareButton.semanticContentAttribute = .forceRightToLeft
        
        priceInputField.keyboardType = .numberPad
        priceInputField.font = .systemFont(ofSize: 17)
    }
    
    private func layout() {
        [priceInputField,freeshareButton].forEach {
            contentView.addSubview($0)
        }
        
        priceInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        freeshareButton.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(15)
            $0.width.equalTo(100)
        }
    }
}
