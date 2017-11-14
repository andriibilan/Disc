//
//  RoundButton.swift
//  DiscountApp
//
//  Created by andriibilan on 11/13/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

// made my button round
@IBDesignable public class MyButton: UIButton
{
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
    
}

