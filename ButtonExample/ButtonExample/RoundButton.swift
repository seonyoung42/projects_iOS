//
//  RoundButton.swift
//  ButtonExample
//
//  Created by 장선영 on 2021/12/19.
//

import UIKit

public class RoundButton: UIButton {
    public var isRound = false {
            didSet {
                if isRound {
                    self.layer.cornerRadius = self.bounds.height/2
                }
            }
        }
}
