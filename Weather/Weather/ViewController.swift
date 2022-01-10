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
        stakView.alignment = .center
        stakView.translatesAutoresizingMaskIntoConstraints = false
        return stakView
    }()
    
    let weatherStackView: UIStackView = {
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
        view.backgroundColor = .white
        view.addSubview(cityNameTextField)
        view.addSubview(button)
        view.addSubview(weatherStackView)
        
        let safeArea = view.safeAreaLayoutGuide
        cityNameTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30).isActive = true
        cityNameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        cityNameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        
        button.topAnchor.constraint(equalTo: cityNameTextField.bottomAnchor, constant: 24).isActive = true
        button.centerXAnchor.constraint(equalTo: cityNameTextField.centerXAnchor).isActive = true
        
        weatherStackView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50).isActive = true
        weatherStackView.leadingAnchor.constraint(equalTo: cityNameTextField.leadingAnchor).isActive = true
        weatherStackView.trailingAnchor.constraint(equalTo: cityNameTextField.trailingAnchor).isActive = true
        
        weatherStackView.addArrangedSubview(stackView1)
        weatherStackView.addArrangedSubview(stackView3)
        
        stackView1.addArrangedSubview(cityNameLabel)
        stackView1.addArrangedSubview(weatherDescriptionLabel)
        
        stackView3.addArrangedSubview(tempLabel)
        stackView3.addArrangedSubview(stackView2)
        
        stackView2.addArrangedSubview(maxTempLabel)
        stackView2.addArrangedSubview(minTempLabel)
        
    }
    
    
    @objc func tapFetchWeatherButton() {
        if let cityName = self.cityNameTextField.text {
            getCurrentWeather(cityName: cityName )
            self.view.endEditing(true)
        }
    }
    
    
    func getCurrentWeather(cityName: String) {

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=개인 API KEY") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] data, response ,error in
            let successRange = (200..<300)

            guard let data = data, error == nil else {
                return }

            let decoder = JSONDecoder()

            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {

                guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else { return }
                DispatchQueue.main.async {
                    self?.weatherStackView.isHidden = false
                    self?.configureView(weatherInformation: weatherInformation)
                }
            } else {
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else { return }
                DispatchQueue.main.async {
                    self?.showAlert(errorMessage: errorMessage.message)
                }
            }
        }.resume()
    }

    func showAlert(errorMessage: String) {
        let ac = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }

    func configureView(weatherInformation: WeatherInformation) {
        
        self.cityNameLabel.text = weatherInformation.name
        if let weather = weatherInformation.weather.first {
            self.weatherDescriptionLabel.text = weather.description
        }
        self.tempLabel.text = "\(Int(weatherInformation.temp.temp - 273.15)) 도"
        self.maxTempLabel.text = "최고 \(Int(weatherInformation.temp.maxTemp - 273.15))도"
        self.minTempLabel.text = "최저 \(Int(weatherInformation.temp.minTemp - 273.15))도"
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
