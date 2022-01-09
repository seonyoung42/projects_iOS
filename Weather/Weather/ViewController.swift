//
//  ViewController.swift
//  Weather
//
//  Created by 장선영 on 2022/01/07.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    let cityNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("날씨 가져오기", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapFetchWeatherButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.text = "서울"
        return label
    }()
    
    let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "맑음"
        return label
    }()

    let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.text = "섭씨 23도"
        return label
    }()
    
    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "최고 30도"
        return label
    }()
    
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "최저 20도"
        return label
    }()
    
    let stackView1: UIStackView = {
        let stakView = UIStackView()
        stakView.axis = .vertical
        stakView.spacing = 8
        stakView.alignment = .center
        stakView.translatesAutoresizingMaskIntoConstraints = false
        return stakView
    }()
    
    let stackView2: UIStackView = {
        let stakView = UIStackView()
        stakView.axis = .horizontal
        stakView.spacing = 20
        stakView.translatesAutoresizingMaskIntoConstraints = false
        return stakView
    }()
    
    let stackView3: UIStackView = {
        let stakView = UIStackView()
        stakView.axis = .vertical
        stakView.spacing = 3
        stakView.translatesAutoresizingMaskIntoConstraints = false
        return stakView
    }()
    
    let stackView4: UIStackView = {
        let stakView = UIStackView()
        stakView.axis = .vertical
        stakView.alignment = .center
        stakView.spacing = 10
        stakView.isHidden = true
        stakView.translatesAutoresizingMaskIntoConstraints = false
        return stakView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(cityNameTextField)
        view.addSubview(button)
        view.addSubview(stackView4)
        
        let safeArea = view.safeAreaLayoutGuide
        cityNameTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30).isActive = true
        cityNameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        cityNameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        
        button.topAnchor.constraint(equalTo: cityNameTextField.bottomAnchor, constant: 24).isActive = true
        button.centerXAnchor.constraint(equalTo: cityNameTextField.centerXAnchor).isActive = true
        
        stackView4.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50).isActive = true
        stackView4.leadingAnchor.constraint(equalTo: cityNameTextField.leadingAnchor).isActive = true
        stackView4.trailingAnchor.constraint(equalTo: cityNameTextField.trailingAnchor).isActive = true
        
        stackView4.addArrangedSubview(stackView1)
        stackView4.addArrangedSubview(stackView3)
        
        stackView1.addArrangedSubview(cityNameLabel)
        stackView1.addArrangedSubview(weatherDescriptionLabel)
        
        stackView3.addArrangedSubview(tempLabel)
        stackView3.addArrangedSubview(stackView2)
        
        stackView2.addArrangedSubview(maxTempLabel)
        stackView2.addArrangedSubview(minTempLabel)
        
        
    }
    
    
    @objc func tapFetchWeatherButton() {
        
    }


}

struct PreView: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}


#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(viewController: self)
        }
}
#endif
