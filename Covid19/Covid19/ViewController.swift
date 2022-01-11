//
//  ViewController.swift
//  Covid19
//
//  Created by 장선영 on 2022/01/09.
//

import UIKit
import SwiftUI
import Alamofire
import Charts

class ViewController: UIViewController {
    
    let label1: UILabel = {
        let label = UILabel()
        label.text = "국내확진자"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalCaseLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.text = "국내 신규 확진자"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newCaseLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let pieChartView: PieChartView = {
        let view = PieChartView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
//    let button: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("버튼", for: .normal)
//        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
//        button.layer.borderWidth = 5
//        button.layer.borderColor = UIColor.gray.cgColor
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicatorView.startAnimating()
        self.view.backgroundColor = .white
        view.addSubview(labelStackView)
        view.addSubview(pieChartView)
        view.addSubview(indicatorView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        labelStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        labelStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        
        pieChartView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 24).isActive = true
        pieChartView.leadingAnchor.constraint(equalTo: labelStackView.leadingAnchor).isActive = true
        pieChartView.trailingAnchor.constraint(equalTo: labelStackView.trailingAnchor).isActive = true
        pieChartView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -24).isActive = true
        
        indicatorView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        
        labelStackView.addArrangedSubview(stackView1)
        labelStackView.addArrangedSubview(stackView2)
        
        stackView1.addArrangedSubview(label1)
        stackView1.addArrangedSubview(totalCaseLabel)
        
        stackView2.addArrangedSubview(label3)
        stackView2.addArrangedSubview(newCaseLabel)
        
        fetchCovidOverview { [weak self] result in
            guard let self = self else { return }
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            self.labelStackView.isHidden = false
            self.pieChartView.isHidden = false
            switch result {
            case let .success(result):
//                DispatchQueue.main.async {
//                    self.configureStack(koreaCovidOverview: result.korea)
//                }
                // alamofire의 response의 completionhandler는 mainthread에서 작동하기 때문에 main dispatchqueue름 만들어주지 않아도 됨
                self.configureStack(koreaCovidOverview: result.korea)
                let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: result)
                self.configurePieChartView(covidCityList: covidOverviewList)
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
    
    @objc func tapButton() {
        debugPrint("Button Tapped")
    }
    
    func fetchCovidOverview(
        completionHandler: @escaping (Result<CityCovidOverview, Error>) -> Void
    ) {
       let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey": "zmgWZa6BOhkuU1XE7tYLRcyqpjeDfbKow"
        ]
        
        AF.request(url, method: .get, parameters: param)
            .responseData(completionHandler: { response in
            switch response.result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CityCovidOverview.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
                
            case let .failure(error):
                completionHandler(.failure(error))
            }
            
        })
    }
    
    func configureStack(koreaCovidOverview: CityOverview) {
        self.totalCaseLabel.text = "\(koreaCovidOverview.totalCase) 명"
        self.newCaseLabel.text = "\(koreaCovidOverview.newCase) 명"
    }
    
    func makeCovidOverviewList(
        cityCovidOverview: CityCovidOverview) -> [CityOverview] {
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.daegu,
            cityCovidOverview.daejeon,
            cityCovidOverview.gangwon,
            cityCovidOverview.gwangju,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.incheon,
            cityCovidOverview.jeju,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.jeonbuk,
            cityCovidOverview.jeonnam
        ]
    }
    
    func configurePieChartView(covidCityList: [CityOverview]) {
        self.pieChartView.delegate = self
        let entries = covidCityList.compactMap { [weak self] overview -> PieChartDataEntry? in
            guard let self = self else { return nil }
            return PieChartDataEntry(value: self.removeFormatString(string: overview.newCase),
                                     label: overview.countryName,
                                     data: overview)
        }
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .black
        dataSet.valueTextColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        dataSet.colors = ChartColorTemplates.vordiplom() + ChartColorTemplates.joyful() + ChartColorTemplates.pastel() + ChartColorTemplates.material()
        
        self.pieChartView.data = PieChartData(dataSet: dataSet)
        self.pieChartView.spin(duration: 0.3, fromAngle: self.pieChartView.rotationAngle, toAngle: self.pieChartView.rotationAngle + 50)
    }
    
    func removeFormatString(string: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0
    }
}

extension ViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let covidDetailVC = UIStoryboard(name: "CovidDetailStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CovidDetailVC") as? CovidDetailViewController else { return }
        
        guard let covidOverview = entry.data as? CityOverview else { return }
        covidDetailVC.covidOverview = covidOverview
        self.navigationController?.pushViewController(covidDetailVC, animated: true)
    }
}

//struct PreView: PreviewProvider {
//    static var previews: some View {
//        ViewController().toPreview()
//    }
//}
//
//
//#if DEBUG
//extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//            let viewController: UIViewController
//
//            func makeUIViewController(context: Context) -> UIViewController {
//                return viewController
//            }
//
//            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//            }
//        }
//
//        func toPreview() -> some View {
//            Preview(viewController: self)
//        }
//}
//#endif
