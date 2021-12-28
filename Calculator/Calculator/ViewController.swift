//
//  ViewController.swift
//  Calculator
//
//  Created by 장선영 on 2021/12/15.
//

import UIKit

enum Operation {
    case Add
    case Subtract
    case Multiply
    case Divide
    case unknown
}

class ViewController: UIViewController {
    
    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation: Operation = .unknown
    
    let resultLabel: UILabel = {
        let label = UILabel()
        
        label.text = "0"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let padView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView1: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 5

        return stackView
    }()

    let stackView2: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
                
        return stackView
    }()
    
    let stackView3: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()
    
    let stackView4: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
    
        return stackView
    }()
    
    let stackView5: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 5
        
        return stackView
    }()
    
    let num1button: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("1", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)

        return button
    }()
    
    let num2button: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("2", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)

        return button
    }()
    let num3button: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("3", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)


        return button
    }()
    let num4Button: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("4", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)

        return button
    }()
    let num5Button: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("5", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)

        return button
    }()
    let num6button: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("6", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)

        return button
    }()
    let num7Button: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("7", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)

        return button
    }()
    
    let num8Button: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("8", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)

        return button
    }()
    
    let num9Button: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("9", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)

        return button
    }()
    
    let num0button: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("0", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapNumberButton(_:)), for: .touchUpInside)

        return button
    }()
    
    let ACButton: RoundButton = {
        let button = RoundButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("AC", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1)
        button.addTarget(self, action: #selector(tapClearButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let divideButton: RoundButton = {
        
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("/", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapDivideButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let multiplyButton: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapMultiplyButton(_:)), for: .touchUpInside)

        return button
    }()
    
    let subtractButton: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapSubtractButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let addButton: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapAddButton(_:)), for: .touchUpInside)

        return button
    }()
    
    let pointButton: RoundButton = {
        let button = RoundButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(".", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapDotButton(_:)), for: .touchUpInside)

        return button
    }()
    
    let resultButton: RoundButton = {
        
        let button = RoundButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("=", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapEqualButton(_:)), for: .touchUpInside)

        return button
    }()
    
    let wholeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.padView.backgroundColor = .black
        
        self.view.addSubview(resultLabel)
        self.view.addSubview(padView)
        self.padView.addSubview(wholeStackView)
        setWholeStackView()
        
        let safeArea = self.view.safeAreaLayoutGuide

        self.resultLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24).isActive = true
        self.resultLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        self.resultLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        self.resultLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.padView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 24).isActive = true
        self.padView.leadingAnchor.constraint(equalTo: resultLabel.leadingAnchor).isActive = true
        self.padView.trailingAnchor.constraint(equalTo: resultLabel.trailingAnchor).isActive = true
        self.padView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -24).isActive = true
 
        self.wholeStackView.topAnchor.constraint(equalTo: padView.topAnchor).isActive = true
        self.wholeStackView.leadingAnchor.constraint(equalTo: padView.leadingAnchor).isActive = true
        self.wholeStackView.trailingAnchor.constraint(equalTo: padView.trailingAnchor).isActive = true
        
        self.ACButton.trailingAnchor.constraint(equalTo: num9Button.trailingAnchor).isActive = true
        self.num0button.trailingAnchor.constraint(equalTo: num2button.trailingAnchor).isActive = true
       
        [divideButton,multiplyButton, subtractButton, addButton,resultButton].forEach {
            $0.backgroundColor = UIColor(red: 254/255, green: 160/255, blue: 10/255, alpha: 1)
        }
        
        [num1button,num2button,num3button,num4Button,num5Button,num6button,num7Button,num8Button,num9Button, num0button, pointButton].forEach {
            $0.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        }
        self.view.layoutIfNeeded()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayouSubviews")
        [num1button,num2button,num3button,num4Button,num5Button,num6button,num7Button,num8Button,num9Button, num0button, pointButton,divideButton,addButton, multiplyButton,subtractButton,resultButton, ACButton].forEach {
            $0.isRound = true
        }
    }
    
    func setStackView1() {
        [ACButton,divideButton].forEach {
            stackView1.addArrangedSubview($0)
            $0.titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
        }

        divideButton.heightAnchor.constraint(equalTo: divideButton.widthAnchor, multiplier: 1).isActive = true
    }
    
    func setStackView2() {
        [num7Button,num8Button,num9Button,multiplyButton].forEach {
            stackView2.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 1.0).isActive = true
            $0.titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
        }
    }
    
    func setStackView3() {
        [num4Button,num5Button,num6button,subtractButton].forEach {
            stackView3.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 1.0).isActive = true
            $0.titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
        }
    }
    
    func setStackView4() {
        [num1button,num2button,num3button,addButton].forEach {
            stackView4.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 1.0).isActive = true
            $0.titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
        }
    }
    
    func setStackView5() {
        [num0button, pointButton, resultButton].forEach {
            stackView5.addArrangedSubview($0)
            $0.titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
        }
        
        pointButton.heightAnchor.constraint(equalTo: pointButton.widthAnchor, multiplier: 1.0).isActive = true
        resultButton.heightAnchor.constraint(equalTo: resultButton.widthAnchor, multiplier: 1.0).isActive = true
    }
    
    func setWholeStackView() {
        [stackView1, stackView2,stackView3,stackView4,stackView5].forEach {
            wholeStackView.addArrangedSubview($0)
        }
        
        [stackView1,stackView2,stackView3,stackView4].forEach {
            $0.heightAnchor.constraint(equalTo: stackView5.heightAnchor).isActive = true
        }
        
        setStackView1()
        setStackView2()
        setStackView3()
        setStackView4()
        setStackView5()
    }
    
    @objc func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) else { return }
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.resultLabel.text = displayNumber
        }
        
    }
    
    @objc func tapClearButton(_ sender: UIButton) {
        displayNumber = ""
        firstOperand = ""
        secondOperand = ""
        result = ""
        currentOperation = .unknown
        resultLabel.text = "0"
    }
    
    @objc func tapDotButton(_ sender: UIButton) {
        if displayNumber.count < 8, !displayNumber.contains(".") {
            displayNumber += displayNumber.isEmpty ? "0." : "."
            resultLabel.text = displayNumber
        }
    }
    
    @objc func tapDivideButton(_ sender: UIButton) {
        operation(.Divide)
    }
    
    @objc func tapMultiplyButton(_ sender: UIButton) {
        operation(.Multiply)
    }
    
    @objc func tapSubtractButton(_ sender: UIButton) {
        operation(.Subtract)
    }
    
    @objc func tapAddButton(_ sender: UIButton) {
        operation(.Add)
    }
    
    @objc func tapEqualButton(_ sender: UIButton) {
        operation(self.currentOperation)
    }
    
    func operation(_ operation: Operation) {
        if currentOperation != .unknown {
            if !self.displayNumber.isEmpty {
                secondOperand = displayNumber
                displayNumber = ""
                
                guard let firstOperand = Double(self.firstOperand) else { return }
                guard let secondOperand = Double(self.secondOperand) else { return }
                
                switch self.currentOperation {
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                default:
                    break
                }
                
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                
                self.firstOperand = result
                resultLabel.text = result
            }
            self.currentOperation = operation
        } else {
            firstOperand = displayNumber
            currentOperation = operation
            displayNumber = ""
        }
    }
}

