//
//  MoreViewController.swift
//  Copy Docket
//
//  Created by Mac on 09/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import FirebaseAuth

class MoreViewController: UIViewController {

    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var lastDonated: UILabel!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var leftSwitch: UISwitch!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var rightSwitch: UISwitch!
    var shared:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clicks()
        // Do any additional setup after loading the view.
    }

}

extension MoreViewController{
    func clicks(){
        
        let gestureProfile = UITapGestureRecognizer(target: self, action:#selector(profileClicked(sender:)))
        self.viewProfile.addGestureRecognizer(gestureProfile)
    
    
        let gestureAbout = UITapGestureRecognizer(target: self, action:#selector(aboutClicked(sender:)))
        self.aboutView.addGestureRecognizer(gestureAbout)
        
        
        let gestureLogout = UITapGestureRecognizer(target: self, action:#selector(logoutClicked(sender:)))
        self.logoutView.addGestureRecognizer(gestureLogout)
        
    }
    
    @objc func profileClicked(sender : UITapGestureRecognizer) {
        if let user = self.shared.user{
        
            var secondStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            var vc = secondStoryBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @objc func aboutClicked(sender : UITapGestureRecognizer) {
        if let user = self.shared.user{
            var secondStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            var vc = secondStoryBoard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
    @objc func logoutClicked(sender : UITapGestureRecognizer) {
        if let user = self.shared.user{
            try! Auth.auth().signOut()
            shared.user = nil
            shared.template = nil
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationViewController = storyboard.instantiateViewController(withIdentifier: "loginNavigation") as! UINavigationController

            self.view.window?.rootViewController = destinationViewController
            self.view.window?.makeKeyAndVisible()
            
        }
    }

}

