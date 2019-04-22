//
//  AboutViewController.swift
//  Copy Docket
//
//  Created by Mac on 14/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isTranslucent = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
        
        
    }




}
