//
//  SourceTextViewController.swift
//  Translate
//
//  Created by 장선영 on 2022/05/28.
//

import UIKit
import SnapKit
import Then

protocol SourceTextViewControllerDelegate: AnyObject {
    func didEnterText(_ sourceText: String)
}

final class SourceTextViewController: UIViewController {
    
    private let placeholderText = "텍스트 입력"
    
    private weak var delegate: SourceTextViewControllerDelegate?
    
    private lazy var textView = UITextView().then {
        $0.text = placeholderText
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: 18.0, weight: .semibold)
        $0.returnKeyType = .done
        $0.delegate = self
    }
    
    init(delegate: SourceTextViewControllerDelegate?) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(textView)
        
        textView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(16.0)
        }
    }
}

// MARK : TextViewDelegate(placeholder 제어)
extension SourceTextViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        
        textView.text = nil
        textView.textColor = .black
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // 키보드에서 done(완료) 를 누른 경우 : 원래는 줄바꿈이지만, dimiss가 되게 함
        guard text == "\n" else { return true }
        delegate?.didEnterText(textView.text)
        dismiss(animated: true)
        
        return true
    }
}
