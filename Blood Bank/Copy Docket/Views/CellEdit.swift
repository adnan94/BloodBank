//
//  CellEdit.swift
//  Copy Docket
//
//  Created by Mac on 01/03/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class CellEdit: UITableViewCell {

    @IBOutlet weak var descrip: UILabel!
    @IBOutlet weak var link: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getDevice(){
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                
            case 1334:
                print("iPhone 6/6S/7/8")
                
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                
            case 2436:
                print("iPhone X, Xs")
                
            case 2688:
                print("iPhone Xs Max")
                
            case 1792:
                print("iPhone Xr")
                
            default:
                print("unknown")
            }
        }
    }
}
