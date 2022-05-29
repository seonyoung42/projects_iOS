//
//  TranslateViewController.swift
//  Translate
//
//  Created by 장선영 on 2022/05/22.
//

import SnapKit
import UIKit
import Then

final class TranslateViewController: UIViewController {
    
    enum `Type` {
        case source
        case target
    }
    
    private var sourceLanguage: Lanugage = .ko
    private var targetLanguage: Lanugage = .en
    
    private lazy var sourceLanguageButton = UIButton().then { button in
        button.setTitle(sourceLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(UIColor.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        button.addTarget(self, action: #selector(didTapSourceLanguageButton), for: .touchUpInside)
    }
    
    private lazy var targetLanguageButton = UIButton().then { button in
        button.setTitle(targetLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(UIColor.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        button.addTarget(self, action: #selector(didTapTargetLanguangeButton), for: .touchUpInside)
    }
    
    private lazy var buttonStackView = UIStackView().then { stackView in
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        [sourceLanguageButton,targetLanguageButton].forEach {
            stackView.addArrangedSubview($0)
        }
    }

    private lazy var resultBaseView = UIView().then { view in
        view.backgroundColor = .white
    }
    
    private lazy var resultLabel = UILabel().then { label in
        label.font = .systemFont(ofSize: 23.0, weight: .bold)
        label.textColor = UIColor.mainTintColor
        label.text = "Hello"
        label.numberOfLines = 0
    }
   
    private lazy var bookmarkButton = UIButton().then { button in
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
    }
    
    private lazy var copyButton = UIButton().then { button in
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
    }
    
    private lazy var sourceLabelBaseButton = UIView().then { view in
        view.backgroundColor = .systemBackground
        
        // View는 Button처럼 addTarget이 없기 때문에 gestureRecognizer를 만들어 추가해준다.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSourceLabelBaseButton))
        view.addGestureRecognizer(tapGesture)
    }

    private lazy var sourceLabel = UILabel().then { label in
        
        label.text = "텍스트 입력"
        label.textColor = .tertiaryLabel
        // TODO: sourceLabel에 입력값 추가되면, placeholder style 해제시키기
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 23.0, weight: .semibold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        setupView()
    }

}


extension TranslateViewController: SourceTextViewControllerDelegate {
    func didEnterText(_ sourceText: String) {
        if sourceText.isEmpty { return }
        
        sourceLabel.text = sourceText
        sourceLabel.textColor = .label
    }
    
}

private extension TranslateViewController {
    func setupView() {
        [buttonStackView,
         resultBaseView,
         resultLabel,
         bookmarkButton,
         copyButton,
         sourceLabelBaseButton,
         sourceLabel].forEach {
            view.addSubview($0)
        }
        
        let defaultSpacing: CGFloat = 16.0
        
        buttonStackView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(defaultSpacing)
            $0.height.equalTo(50.0)
        }
        
        resultBaseView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(defaultSpacing)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bookmarkButton).offset(defaultSpacing)
        }
        
        resultLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(resultBaseView).inset(24.0)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.leading.equalTo(resultLabel)
            $0.top.equalTo(resultLabel.snp.bottom).offset(24.0)
            $0.width.height.equalTo(40.0)
        }
        
        copyButton.snp.makeConstraints {
            $0.leading.equalTo(bookmarkButton.snp.trailing).offset(8.0)
            $0.top.equalTo(bookmarkButton)
            $0.width.height.equalTo(40.0)
        }
        
        sourceLabelBaseButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(resultBaseView.snp.bottom).offset(defaultSpacing)
            $0.bottom.equalToSuperview().inset(tabBarController?.tabBar.frame.height ?? 0.0)
        }
        
        sourceLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(sourceLabelBaseButton).inset(24.0)
        }
    }
    
    
    @objc func didTapSourceLabelBaseButton() {
        let nextVC = SourceTextViewController(delegate: self)
        self.present(nextVC, animated: true)
    }
    
    @objc func didTapSourceLanguageButton() {
        didTapLanguageButton(type: .source)
    }
    
    @objc func didTapTargetLanguangeButton() {
        didTapLanguageButton(type: .target)
    }
    
    // -> enum은 @objc에서 사용될 수 없음
    func didTapLanguageButton(type: Type) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        Lanugage.allCases.forEach { language in
            let action = UIAlertAction(title: language.title, style: .default) { _ in
                
                switch type {
                case .source:
                    self.sourceLanguage = language
                    self.sourceLanguageButton.setTitle(language.title, for: .normal)
                case .target:
                    self.targetLanguage = language
                    self.targetLanguageButton.setTitle(language.title, for: .normal)
                }
            }
            alertController.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "취소하기", style: .cancel)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
}
