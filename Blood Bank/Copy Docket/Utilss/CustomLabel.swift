//
//  CustomLabel.swift
//  Copy Docket
//
//  Created by Mac on 05/03/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

@IBDesignable class CustomLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    @IBInspectable var cornerRadius:CGFloat = 0.0{
        didSet{
            setNeedsDisplay()
        }
    }

}
