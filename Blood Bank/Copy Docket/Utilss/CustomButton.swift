//
//  CustomButton.swift
//  CustomViews
//
//  Created by Mac on 03/03/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {

 
 override func draw(_ rect: CGRect) {
   self.layer.cornerRadius = cornerRadius
    self.layer.borderWidth = border
    self.layer.borderColor = borderColor.cgColor
    self.layer.shadowOffset = shadow
    self.clipsToBounds = true
    }
 
    @IBInspectable var cornerRadius:CGFloat = 0.0{
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var border:CGFloat = 0.0{
        didSet{
            setNeedsDisplay()
        }
    }

    @IBInspectable var borderColor:UIColor = UIColor.clear{
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadow:CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet{
            setNeedsDisplay()
        }
    }
}
