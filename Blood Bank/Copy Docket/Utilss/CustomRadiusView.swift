//
//  CustomRadiusView.swift
//  Copy Docket
//
//  Created by Mac on 03/03/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
@IBDesignable class CustomRadiusView: UIView {
    
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
