//
//  ItemSettings.swift
//  Copy Docket
//
//  Created by Mac on 04/03/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ItemSettings: UITableViewCell {

    @IBOutlet weak var valuee: UILabel!
    @IBOutlet weak var titlee: UILabel!
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
                valuee.font = .systemFont(ofSize: 18)
                titlee.font = .systemFont(ofSize: 18)
                
            case 1334:
                print("iPhone 6/6S/7/8")
                valuee.font = .systemFont(ofSize: 18)
                titlee.font = .systemFont(ofSize: 18)
                
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                valuee.font = .systemFont(ofSize: 22)
                titlee.font = .systemFont(ofSize: 22)
                
            case 2436:
                print("iPhone X, Xs")
                valuee.font = .systemFont(ofSize: 20)
                titlee.font = .systemFont(ofSize: 20)
                
            case 2688:
                print("iPhone Xs Max")
                valuee.font = .systemFont(ofSize: 22)
                titlee.font = .systemFont(ofSize: 22)
                
            case 1792:
                print("iPhone Xr")
                valuee.font = .systemFont(ofSize: 22)
                titlee.font = .systemFont(ofSize: 22)
                
            default:
                print("unknown")
            }
        }
    }
}
