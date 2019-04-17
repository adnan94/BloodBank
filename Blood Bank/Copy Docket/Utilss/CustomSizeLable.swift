//
//  CustomSizeLable.swift
//  Copy Docket
//
//  Created by Mac on 14/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class CustomSizeLable: UILabel {

    
    override func layoutSubviews() {
        super.layoutSubviews()
        font = fontToFitHeight()
    }
    
    // Returns an UIFont that fits the new label's height.
    private func fontToFitHeight() -> UIFont {
        
        var minFontSize: CGFloat = 10// CGFloat 18
        var maxFontSize: CGFloat = 100    // CGFloat 67
        var fontSizeAverage: CGFloat = 0
        var textAndLabelHeightDiff: CGFloat = 0
        
        while (minFontSize <= maxFontSize) {
            fontSizeAverage = minFontSize + (maxFontSize - minFontSize) / 2
            
            if let labelText: NSString = text as! NSString {
                let labelHeight = frame.size.height
                
                let testStringHeight = labelText.size(
                    withAttributes: [NSAttributedString.Key.font: font.withSize(fontSizeAverage)]
                    ).height
                
                textAndLabelHeightDiff = labelHeight - testStringHeight
                
                if (fontSizeAverage == minFontSize || fontSizeAverage == maxFontSize) {
                    if (textAndLabelHeightDiff < 0) {
                        return font.withSize(fontSizeAverage - 1)
                    }
                    return font.withSize(fontSizeAverage)
                }
                
                if (textAndLabelHeightDiff < 0) {
                    maxFontSize = fontSizeAverage - 1
                    
                } else if (textAndLabelHeightDiff > 0) {
                    minFontSize = fontSizeAverage + 1
                    
                } else {
                    return font.withSize(fontSizeAverage)
                }
            }
        }
        return font.withSize(fontSizeAverage)
    }
}


