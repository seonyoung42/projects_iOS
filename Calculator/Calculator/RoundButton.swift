//
//  RoundButton.swift
//  Calculator
//
//  Created by 장선영 on 2021/12/15.
//

import UIKit

public class RoundButton: UIButton {
    public var isRound = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height/2
                print("make Button Rounded")
                print(self.bounds.height)
                print(self.layer.cornerRadius)
            }
        }
    }
    
//    public override func layoutSubviews() {
//        super.layoutSubviews()
//        layer.cornerRadius = layer.frame.height / 2
//        print("layout subViews - \(layer.cornerRadius)")
//    }
}
