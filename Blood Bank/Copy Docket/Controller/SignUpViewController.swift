//
//  SignUpViewController.swift
//  Copy Docket
//
//  Created by Mac on 27/02/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class SignUpViewController: UIViewController {

 
    @IBOutlet weak var registerTop: NSLayoutConstraint!
    @IBOutlet weak var contactTop: NSLayoutConstraint!
    @IBOutlet weak var confirmPasswordTop: NSLayoutConstraint!
    @IBOutlet weak var passwordTop: NSLayoutConstraint!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var emailTop: NSLayoutConstraint!
    @IBOutlet weak var contactText: UITextField!
    @IBOutlet weak var confirmText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var fullName: UITextField!
    var hud:JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contactText.delegate = self
        self.title = "Register"
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        getDevice()
        
      }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated:true);
        
    }
    
    
    @IBAction func register(_ sender: Any) {
        if valid(){
            self.hud.show(in: view)
            
            ref.child("Users").queryOrdered(byChild: "number").queryEqual(toValue:contactText.text!).observeSingleEvent(of: .value, with: { snapshot in
                
                if snapshot.exists() {
                    toast(controller: self, message: "User with this number already exists", seconds: 1.5)
                    self.hud.dismiss()
                }else{
                    self.doRegisterProcess()
                }})
            
        }
    }
   

}
extension SignUpViewController :  UITextFieldDelegate{
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.contactText{
            let  maxLength = 11
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
            
        }
        return false
    }
    
    func doRegisterProcess(){
        Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authResult, error) in
            if error == nil {
                self.addUser(push: authResult!.user.uid)
            } else {
                self.hud.dismiss()
                toast(controller: self, message: error!.localizedDescription, seconds: 2.0)
            }
        }
    }
    
    func addUser(push:String){
        var user = Dictionary<String, Any>()
        print("add user running")
        user["name"] = fullName.text!
        user["email"] = emailText.text!
        user["number"] = contactText.text!
        user["type"] = 1
        user["picUrl"] = "N/A"
        user["emailVerified"] = 0
        user["password"] = passwordText.text!
        user["active"] = 1
        user["date"] = ServerValue.timestamp()
        user["id"] = push
        user["deviceID"] = UIDevice.current.identifierForVendor!.uuidString
      
        user["dateOfBirth"] = CLong(0)
        user["lastDonated"] = CLong(0)
        user["bloodGroup"] = "N/A"
        user["gender"] = "N/A"
        user["profileCompleted"] = false
        
        
        
        ref.child("Users").child(push).setValue(user, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print("\(error!.localizedDescription)")
            } else {
                self.hud.dismiss()
                self.navigationController?.popViewController(animated: true)
                try! Auth.auth().signOut()
                toast(controller: self, message: "Registered Successfully", seconds: 2.0)

                
                
            }
        })
        
    }
    
    
    func getDevice(){
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
//           welcomeTop.constant = 25
//                nameTop.constant = 30
                fullName.font = .systemFont(ofSize:16)
                emailTop.constant = 30
                emailText.font = .systemFont(ofSize:16)
                contactTop.constant = 30
                contactText.font = .systemFont(ofSize:16)
                passwordTop.constant = 30
                passwordText.font = .systemFont(ofSize:16)
                confirmPasswordTop.constant = 30
                confirmText.font = .systemFont(ofSize:16)
                registerTop.constant = 40
                register.titleLabel?.font = .systemFont(ofSize: 16)
                welcomeText.font = .systemFont(ofSize: 25)
                text2.font = .systemFont(ofSize:16)
                
            case 1334:
                print("iPhone 6/6S/7/8")
//                welcomeTop.constant = 30
                fullName.font = .systemFont(ofSize:18)
                
                emailTop.constant = 40
//                nameTop.constant = 45
                
                
                emailText.font = .systemFont(ofSize:18)
                contactTop.constant = 40
                contactText.font = .systemFont(ofSize:18)
                passwordTop.constant = 40
                passwordText.font = .systemFont(ofSize:18)
                confirmPasswordTop.constant = 40
                confirmText.font = .systemFont(ofSize:18)
                registerTop.constant = 40
                register.titleLabel?.font = .systemFont(ofSize: 18)
              
                
                welcomeText.font = .systemFont(ofSize: 30)
                text2.font = .systemFont(ofSize:18)
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
//                welcomeTop.constant = 25
//                nameTop.constant = 30
            case 2436:
                print("iPhone X, Xs")
                
//                welcomeTop.constant = 25
//                nameTop.constant = 30
            case 2688:
                print("iPhone Xs Max")
                
            case 1792:
                print("iPhone Xr")
                
            default:
                print("unknown")
            }
        }
    }
    func valid()->Bool{
        var flag : Bool = true
         if fullName.text == nil{
            flag = false
            toast(controller: self, message: "Enter name", seconds: 1.5)
        }else if fullName.text!.count < 2{
            flag = false
            toast(controller: self, message: "Invalid name", seconds: 1.5)
        }
        else if emailText.text == nil{
            flag = false
            toast(controller: self, message: "Enter email", seconds: 1.5)
        }else if contactText.text == nil{
            flag = false
            toast(controller: self, message: "Enter number", seconds: 1.5)
        }
        else if contactText.text!.count < 11{
            flag = false
            toast(controller: self, message: "Number length should be 11", seconds: 1.5)
        }else if passwordText.text == nil {
            flag = false
            toast(controller: self, message: "Enter password", seconds: 1.5)
        }else if passwordText.text!.count < 6{
            flag = false
            toast(controller: self, message: "Password length should be 6 or greater", seconds: 1.5)
         }else if confirmText.text!.elementsEqual(passwordText.text!) == false{
            flag = false
            toast(controller: self, message: "Password not matched", seconds: 1.5)
        }
        return flag
    }
    
    
}
