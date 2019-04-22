//
//  MoreViewController.swift
//  Copy Docket
//
//  Created by Mac on 09/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import FirebaseAuth
import CodableFirebase
import Firebase
import JGProgressHUD

class MoreViewController: UIViewController  {

    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var lastDonated: UILabel!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var leftSwitch: UISwitch!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var rightSwitch: UISwitch!
    var shared:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var type:Int!
    var hud:JGProgressHUD!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inits()
        clicks()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkSwitch()
    }

}

extension MoreViewController{
  
    
    func updateStatus(){
        

    if (shared.user!.type == type) == false{
            shared.user!.type = type
        let dict = try! FirebaseEncoder().encode(shared.user!)
        
        ref.child("Users").child(shared.user!.id).setValue(dict, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print("\(error!.localizedDescription)")
            } else {
                self.navigationController?.popViewController(animated: true)
                self.hud.dismiss()
                toast(controller: self, message: "Profile Updated", seconds: 1.5)
            }
        })
        }}
    
    func checkSwitch(){
        type = shared.user!.type
        
        if self.shared.user?.type == 1{
            
            self.leftSwitch.isOn = false
            self.rightSwitch.setOn(true, animated: true)
            self.rightSwitch.isOn = true
            
        }else if self.shared.user?.type == 2{
            
            self.leftSwitch.isOn = true
            self.rightSwitch.isOn = false
            
        }else if self.shared.user?.type == 3{
            
            self.leftSwitch.isOn = true
            self.rightSwitch.isOn = true
            
        }else{
            self.leftSwitch.isOn = false
            self.rightSwitch.isOn = false
            
        }
        
    }
    
    func inits(){
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        
        if shared.user!.lastDonated == 0{
        self.lastDonated.text = "Never Donated"
        }else{
            self.lastDonated.text = formaterDate(date: shared.user!.lastDonated)
        }
        
        
        
        
        }

    func clicks(){
        
        let gestureProfile = UITapGestureRecognizer(target: self, action:#selector(profileClicked(sender:)))
        self.viewProfile.addGestureRecognizer(gestureProfile)
    
    
        let gestureAbout = UITapGestureRecognizer(target: self, action:#selector(aboutClicked(sender:)))
        self.aboutView.addGestureRecognizer(gestureAbout)
        
        
        let gestureLogout = UITapGestureRecognizer(target: self, action:#selector(logoutClicked(sender:)))
        self.logoutView.addGestureRecognizer(gestureLogout)
        
        
        self.leftSwitch.addTarget(self, action: #selector(valueChange), for:UIControl.Event.valueChanged)
          self.rightSwitch.addTarget(self, action: #selector(valueChange), for:UIControl.Event.valueChanged)
       
    }
    
    @objc func valueChange(mySwitch: UISwitch) {
       
        if self.leftSwitch.isOn && self.rightSwitch.isOn{
            type = 3
            updateStatus()
        }else if self.rightSwitch.isOn{
           type = 1
            updateStatus()
        }else if self.leftSwitch.isOn{
            type = 2
            updateStatus()
        }else{
            checkSwitch()
        }
     
        
        
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

