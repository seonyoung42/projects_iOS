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
            }
        }
    }
    
//    public override func layoutSubviews() {
//        super.layoutSubviews()
//        layer.cornerRadius = layer.frame.height / 2
//    }
}
