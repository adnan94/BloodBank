//
//  ItemHomeScreen.swift
//  Copy Docket
//
//  Created by Mac on 28/02/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ItemHomeScreen: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var addLinks: UIButton!
    var position:Int?

    @IBOutlet weak var viewLower: UIView!
    @IBOutlet weak var viewIamge: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var link1: UIButton!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var link8: UIButton!
    @IBOutlet weak var link2: UIButton!
    
    @IBOutlet weak var link4: UIButton!
    @IBOutlet weak var link6: UIButton!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
 
    @IBOutlet weak var link5: UIButton!
    @IBOutlet weak var link7: UIButton!
    
    @IBOutlet weak var link3: UIButton!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
  
    
    
    
    override func awakeFromNib() {
        getDevice()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
      
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(self.handleTapImage(_:)))
        tapImage.delegate = self
//
        self.mainView.addSubview(shareView)
        self.shareView.addGestureRecognizer(tap)
  
        logoImage.isUserInteractionEnabled = true
        self.viewIamge.addSubview(logoImage)
        self.logoImage.addGestureRecognizer(tapImage)
    }
    
    
    @objc func handleTapImage(_ sender: UITapGestureRecognizer) {
        //        print("Share clicked !")
        delegate?.didTapLogoInCell(self, position: position!)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
//        print("Share clicked !")
        delegate?.didTapShareButtonInCell(self,position: position!)
    }
    @IBAction func addLinkButton(_ sender: Any) {
    print("Link clicked")
        delegate?.didTapButtonInCell(self,position: position!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func link1Clicked(_ sender: Any) {
        
        var linkSTR = self.link1.titleLabel?.text!
        let stringArray = linkSTR!.components(separatedBy: CharacterSet.decimalDigits.inverted)
        for item in stringArray {
            if let number = Int(item) {
                delegate?.didTapLink(self, position: position! , linkPos: Int(number))
            }
        }

    }
    
    @IBAction func link8Clicked(_ sender: Any) {
        var linkSTR = self.link8.titleLabel?.text!
        let stringArray = linkSTR!.components(separatedBy: CharacterSet.decimalDigits.inverted)
        for item in stringArray {
            if let number = Int(item) {
                delegate?.didTapLink(self, position: position! , linkPos: Int(number))
            }
        }
    }
    
    @IBAction func link7Clicked(_ sender: Any) {
        var linkSTR = self.link7.titleLabel?.text!
        let stringArray = linkSTR!.components(separatedBy: CharacterSet.decimalDigits.inverted)
        for item in stringArray {
            if let number = Int(item) {
                delegate?.didTapLink(self, position: position! , linkPos: Int(number))
            }
        }
    }
    @IBAction func link6Clicked(_ sender: Any) {
        var linkSTR = self.link6.titleLabel?.text!
        let stringArray = linkSTR!.components(separatedBy: CharacterSet.decimalDigits.inverted)
        for item in stringArray {
            if let number = Int(item) {
                delegate?.didTapLink(self, position: position! , linkPos: Int(number))
            }
        }
    }
    @IBAction func link2Clicked(_ sender: Any) {
        var linkSTR = self.link2.titleLabel?.text!
        let stringArray = linkSTR!.components(separatedBy: CharacterSet.decimalDigits.inverted)
        for item in stringArray {
            if let number = Int(item) {
                delegate?.didTapLink(self, position: position! , linkPos: Int(number))
            }
        }
    }
    
    
    @IBAction func link3Clicked(_ sender: Any) {
        var linkSTR = self.link3.titleLabel?.text!
        let stringArray = linkSTR!.components(separatedBy: CharacterSet.decimalDigits.inverted)
        for item in stringArray {
            if let number = Int(item) {
                delegate?.didTapLink(self, position: position! , linkPos: Int(number))
            }
        }
    }
    
    @IBAction func link4Clicked(_ sender: Any) {
        var linkSTR = self.link4.titleLabel?.text!
        let stringArray = linkSTR!.components(separatedBy: CharacterSet.decimalDigits.inverted)
        for item in stringArray {
            if let number = Int(item) {
                delegate?.didTapLink(self, position: position! , linkPos: Int(number))
            }
        }
    }
    
    @IBAction func link5Clicked(_ sender: Any) {
        var linkSTR = self.link5.titleLabel?.text!
        let stringArray = linkSTR!.components(separatedBy: CharacterSet.decimalDigits.inverted)
        for item in stringArray {
            if let number = Int(item) {
                delegate?.didTapLink(self, position: position! , linkPos: Int(number))
            }
        }
    }
    
    func getDevice(){
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                addLinks.titleLabel?.font = .systemFont(ofSize:12)
                addLinks.layer.cornerRadius = 33
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
