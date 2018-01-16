//
//  RoundedButton.swift
//  slack-clone
//
//  Created by Rohit Rajput on 15/01/18.
//  Copyright © 2018 Rohit Rajput. All rights reserved.
//

import Foundation

@IBDesignable
class RoundedButton : UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
    
}
