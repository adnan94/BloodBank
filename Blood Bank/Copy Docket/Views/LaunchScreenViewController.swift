//
//  LaunchScreenViewController.swift
//  Copy Docket
//
//  Created by Mac on 08/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//


import Firebase
import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageBlood: UIImageView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        textLabel.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animate(withDuration: 2, animations: {
            
            self.imageBlood.frame.origin.y =  ( self.view.frame.height / 2 ) - 10
            
        }, completion:{ (value: Bool) in
            self.textLabel.isHidden = false
           
            
            
            
            UIView.animate(withDuration: 2, animations: {
                
                self.textLabel.frame.origin.y = ( self.view.frame.height / 2 ) - (self.textLabel.frame.height/2) - 10
            }, completion: {(value:Bool) in
            self.checkForAuthentication()
            }
        
        )

        
        })
         }
   
    func checkForAuthentication(){
        if  Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationViewController = storyboard.instantiateViewController(withIdentifier: "loginNavigation") as! UINavigationController
        
            self.view.window?.rootViewController = destinationViewController
            self.view.window?.makeKeyAndVisible()
        }else{
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationViewController = storyboard.instantiateViewController(withIdentifier: "dashboard") as! UITabBarController
            self.view.window?.rootViewController = destinationViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
    
}
