//
//  ViewController.swift
//  Copy Docket
//
//  Created by Mac on 27/02/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD
import CodableFirebase


class ViewController: UIViewController {

    @IBOutlet weak var registerTopCons: NSLayoutConstraint!
    @IBOutlet weak var signTopCons: NSLayoutConstraint!
    @IBOutlet weak var forgotTopCons: NSLayoutConstraint!
    @IBOutlet weak var passwordTopCons: NSLayoutConstraint!
    @IBOutlet weak var emailTopCons: NSLayoutConstraint!
    @IBOutlet weak var logoTopCons: NSLayoutConstraint!
    @IBOutlet weak var forgotText: UIButton!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signButton: UIButton!
    
    var hud:JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        self.getDevice()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func signIn(_ sender: Any) {
        self.hud.show(in: view)
        
        if(validation()){
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                if user == nil{
                    toast(controller: self, message: error!.localizedDescription, seconds: 2.5)
             self.hud.dismiss()
                }else{
                    
                    self.self.emailText.text = ""
                    self.passwordText.text = ""
                    
                    self.gotoHome()
                    
                    
                    
                }
            }
        }
    }
    
    @IBAction func register(_ sender: Any) {
    goRegister()
        
    }
    
    
    func goRegister(){
        var secondStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        var theInitialViewController: UIViewController? = secondStoryBoard.instantiateInitialViewController()
        var vc = secondStoryBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
        //    self.dismiss(animated: true, completion: nil)
//        toast(controller: self, message:"Login Successfully", seconds: 1.5)
        
    }

    
    
    @IBAction func forgetPassword(_ sender: Any) {
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Forgot your password", message: "Enter your email here we sent you email for password reset...", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Enter email..."
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            if let email = textField.text {
                Auth.auth().sendPasswordReset(withEmail: email as! String) { error in
                    // Your code here
                    if let error = error{
                        toast(controller: self, message: error.localizedDescription, seconds: 1.0)
                    }else{
                        toast(controller: self, message: "Password reset email send", seconds: 1.0)
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
          alert?.dismiss(animated: true, completion: nil)
        }))
        // 4. Present the alert.
        self.present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    
//    @objc func handleCustomFBLogin() {
//        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: self) { (result, err) in
//            if err != nil {
//                print("Custom FB Login failed:", err)
//                return
//            }
//            self.showEmail()
//        }
//    }
    
    ///Google Stuff
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if error != nil{
//            print(error.localizedDescription)
//            return
//        }
//        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
//        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            if let authResult = authResult{
//                self.checkForUSerExists(email: authResult.user.email!, id: authResult.user.uid, name: authResult.user.displayName!)
//            }
//        }
//    }
//
//
    
//    func sign(_ signIn: GIDSignIn!,
//              present viewController: UIViewController!) {
//        self.present(viewController, animated: true, completion: nil)
//    }
//
//
//    func showEmail(){
//
//        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
//
//            if err != nil {
//                print("Failed to start graph request:", err)
//                return
//            }
//
//            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//                if let error = error {
//                    toast(controller: self, message: error.localizedDescription, seconds: 2.0)
//                    return
//                }
//
//                if let authResult = authResult{
//                    self.checkForUSerExists(email: authResult.user.email!, id: authResult.user.uid, name: authResult.user.displayName!)
//                }
//            }
//        }
//    }
//
    
    func checkForUSerExists(email:String, id:String , name:String){
        
        ref.child("Users").child(id).observe(.value) { snapshot in
            if snapshot.exists() == false{
                self.addUser(push: id, name: name, email: email)
                
            }else{
                self.gotoHome()
                //                toast(controller: self, message: "Logged In", seconds: 1.0)
            }
        }
    }
    
    
    
    
   
    
    //    func sign(_ signIn: GIDSignIn!,
    //              present viewController: UIViewController!) {
    //        self.present(viewController, animated: true, completion: nil)
    //    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationItem.setHidesBackButton(true, animated:true);
//
//    }
//    @IBAction func facebook(_ sender: Any) {
//        handleCustomFBLogin()
//    }
//    @IBAction func google(_ sender: Any) {
//        handleGoogleLogin()
//    }
    
    
   
    
}



extension ViewController{
    
    func initilizations(){
//        self.navigationItem.setHidesBackButton(true, animated:true);
//        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back.png")
//        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back.png")
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //Google Stuff
//        GIDSignIn.sharedInstance()?.uiDelegate = self
        
    }
    
    func handleGoogleLogin(){
//        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().signIn()
    }
    
    func gotoHome(){
        if let user:String = Auth.auth().currentUser?.uid{
            ref.child("Users").child(user).observeSingleEvent(of: .value, with: { snapshot in
                
                if snapshot.exists(){
                    let dataShot:DataSnapshot = snapshot as! DataSnapshot
                    let data:[String:Any] = dataShot.value as! [String: Any]
                    let user = User(shot: data)
                    if user.active! == 0{
                        toast(controller: self, message:"Account Deactivited", seconds: 1.5)
                        try! Auth.auth().signOut()
                        self.hud.dismiss()
                    }else if user.type == 0 {
                        toast(controller: self, message:"Admin Not Allowed", seconds: 1.5)
                        try! Auth.auth().signOut()
                        self.hud.dismiss()
                    }else{
                        //////////Update User Device Id
                        if user.deviceID!.elementsEqual(UIDevice.current.identifierForVendor!.uuidString){
                            self.go()
                        }else{
                            
                            user.deviceID = UIDevice.current.identifierForVendor!.uuidString
                            let u = try! FirebaseEncoder().encode(user)

                            ref.child("Users").child(user.id).setValue(u, withCompletionBlock: { (error, snapshot) in
                                if error != nil {
                                    print("\(error!.localizedDescription)")
                                    self.hud.dismiss()
                                } else {
                                    self.go()
                                }
                            })
                        }
                        
                    }
                    
                    
                }else{
                    ref.child("Users").queryOrdered(byChild: "email").queryEqual(toValue:Auth.auth().currentUser?.email!).observeSingleEvent(of: .value, with: { snapshot in
                        if snapshot.exists() {
                            for item in snapshot.children{
                                
                                let dataShot:DataSnapshot = item as! DataSnapshot
                                let data:[String:Any] = dataShot.value as! [String: Any]
                                let user = User(shot: data)
                                if user.active! == 0{
                                    toast(controller: self, message:"Account Deactivited", seconds: 1.5)
                                    try! Auth.auth().signOut()
                                    self.hud.dismiss()
                                }else if user.type == 0 {
                                    toast(controller: self, message:"Admin Not Allowed", seconds: 1.5)
                                    try! Auth.auth().signOut()
                                    self.hud.dismiss()
                                }else{
                                    //////////Update User Device Id
                                    if user.deviceID!.elementsEqual(UIDevice.current.identifierForVendor!.uuidString){
                                        self.go()
                                    }else{
                                        
                                        user.deviceID = UIDevice.current.identifierForVendor!.uuidString
                                        let u = try! FirebaseEncoder().encode(user)
                                        
                                        ref.child("Users").child(user.id).setValue(u, withCompletionBlock: { (error, snapshot) in
                                            if error != nil {
                                                print("\(error!.localizedDescription)")
                                                self.hud.dismiss()
                                            } else {
                                                self.go()
                                            }
                                        })
                                    }
                                    
                                }
                                
                                
                            }
                            
                        }
                    });
                    
                }
            })
        }
    }
    
    func go(){
//        var secondStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//        var theInitialViewController: UIViewController? = secondStoryBoard.instantiateInitialViewController()
//        var vc = secondStoryBoard.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationViewController = storyboard.instantiateViewController(withIdentifier: "dashboard") as! UITabBarController
        //            if let navigationController = self.window?.rootViewController as? UINavigationController{
        //                navigationController.pushViewController(destinationViewController, animated: false)
        self.view.window?.rootViewController = destinationViewController
        self.view.window?.makeKeyAndVisible()
        
        //    self.dismiss(animated: true, completion: nil)
        self.hud.dismiss()
        toast(controller: self, message:"Login Successfully", seconds: 1.5)
        
    }
    func converObjToDic(user:User)->[String:Any]{
        var dict:[String:Any] = [:]
        dict["name"] = user.name
        dict["email"] = user.email
        dict["number"] =  user.number
        dict["type"] =  user.type
        dict["date"] = user.date
        dict["id"] = user.id
        if let active = user.active{
            dict["active"] = active
        }
        if let emailVerified = user.emailVerified{
            dict["emailVerified"] = emailVerified
        }
        if let picUrl = user.picUrl{
            dict["picUrl"] = picUrl
        }
        if let password = user.password{
            dict["password"] = password
        }
        if let deviceID = user.deviceID{
            dict["deviceID"] = deviceID
        }
        
        
        return dict
    }
    
    
    func addUser(push:String,name:String,email:String){
        var user = Dictionary<String, Any>()
        print("add user running")
        user["name"] = name
        user["email"] = email
        user["number"] = "N/A"
        user["type"] = 1
        user["picUrl"] = "N/A"
        user["emailVerified"] = 0
        user["password"] = "N/A"
        user["active"] = 1
        user["date"] = ServerValue.timestamp()
        user["id"] = push
        user["deviceID"] = UIDevice.current.identifierForVendor!.uuidString
        
        ref.child("Users").child(push).setValue(user, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print("\(error!.localizedDescription)")
            } else {
                //+++++++++++++++++++++++
                var map:[String:Any] = [String:Any]()
                map["name"] = name
                map["timestamp"] = ServerValue.timestamp()
                map["userId"] = push
                map["type"] = "NewRegister"
                map["email"] = "\(name) is sucessfully registered in fizyo ."
                map["bookingId"] = "N/A"
                
                ref.child("Notifications").child("Admin").childByAutoId().setValue(map , withCompletionBlock: { (error, snapshot) in
                    if error != nil {
                        print("\(error!.localizedDescription)")
                    } else {
                        self.gotoHome()
                    }
                    
                })
                
            }
        })
        
    }
    
    
    func getDevice(){
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                if let logo = logoTopCons{
                self.logoTopCons.constant = 20
                self.emailTopCons.constant = 30
                self.passwordTopCons.constant = 40
                self.registerTopCons.constant = 20
                self.forgotTopCons.constant = 30
                self.signTopCons.constant = 40
                registerButton.titleLabel?.font = .systemFont(ofSize: 16)
                signButton.titleLabel?.font = .systemFont(ofSize: 16)
                forgotText.titleLabel?.font = .systemFont(ofSize: 16)
                emailText.font = .systemFont(ofSize:16)
                passwordText.font = .systemFont(ofSize:16)
                }
            case 1334:
                print("iPhone 6/6S/7/8")
                if let logo = logoTopCons{
                    self.logoTopCons.constant = 10
                    self.signTopCons.constant = 20
                
                    self.passwordTopCons.constant = 50
                }
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                if let logo = logoTopCons{
                    self.logoTopCons.constant = 10
                    self.signTopCons.constant = 20
                }
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
    func validation()->Bool{
        var flag : Bool = true
        if emailText.text?.count == 0{
            flag = false
            toast(controller: self, message: "Enter email", seconds: 1.5)
        self.hud.dismiss()
        }else if passwordText.text?.count == 0 {
            flag = false
            toast(controller: self, message: "Enter password", seconds: 1.5)
       self.hud.dismiss()
            
        }else if passwordText.text!.count < 6{
            flag = false
            toast(controller: self, message: "Password length should be 6 or greater", seconds: 1.5)
        self.hud.dismiss()
        }
        return flag
    }
    
    
   

}

var ref = Database.database().reference().child("AppData")


func formaterDate(date:CLong)->String{
    let unixTimestamp = date / 1000
    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MM-yyyy"
    let myString = formatter.string(from: date)// string purpose I add here
    let yourDate = formatter.date(from: myString)
    let myStringafd = formatter.string(from: yourDate!)
    return myStringafd
}

func getMonth(date:Date)->String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "LLLL"
    return dateFormatter.string(from: date)
}

func getYear(date:Date)->String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    return dateFormatter.string(from: date)
    
}
func currentDate()->String{
    let now = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-LLLL-yyyy"
    return dateFormatter.string(from: now)
}


func formaterTimeHourAm(date:CLong)->String{
    let unixTimestamp = date / 1000
    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
    let formatter = DateFormatter()
    formatter.dateFormat = "hh aa"
    let myString = formatter.string(from: date)// string purpose I add here
    let yourDate = formatter.date(from: myString)
    let myStringafd = formatter.string(from: yourDate!)
    return myStringafd
}

func currentDateMonthDay()->String{
    let now = Date()
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM"
    return dateFormatter.string(from: now)
}


func shortMonth(mDate:CLong)->String{
    let unixTimestamp = mDate / 1000
    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM"
    return dateFormatter.string(from: date)
}

func shortDate(mDate:CLong)->String{
    let unixTimestamp = mDate / 1000
    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd"
    return dateFormatter.string(from: date)
}

func formaterTime(date:CLong)->String{
    let unixTimestamp = date / 1000
    let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm:aa"
    let myString = formatter.string(from: date)// string purpose I add here
    let yourDate = formatter.date(from: myString)
    let myStringafd = formatter.string(from: yourDate!)
    return myStringafd
}
func toast(controller: UIViewController, message : String, seconds: Double){
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    alert.view.backgroundColor = UIColor.black
    alert.view.alpha = 0.8
    alert.view.layer.cornerRadius = 15
    
    controller.present(alert, animated: true)
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
        alert.dismiss(animated: true)
    }
}

func currentTimeInMilli ()->CLong{
    var currentDate = Date()
    var t = currentDate.timeIntervalSince1970
    var miliCurrent:CLong = CLong(t * 1000)
    return miliCurrent
}



/// Returns the a custom time interval description from another date
func differenceTime(from date: Date) -> String {
    var differenceOfDate = ""
    
    var MINUTE = 60 * 1000
    var HOUR = 60 * MINUTE
    var days = HOUR / 24
    if days > 0{
        differenceOfDate = "\(days)Days \(HOUR)Hr \(MINUTE)Min"
        
    }else{
        differenceOfDate = "\(HOUR)Hr \(MINUTE)Min"
    }
    return "\(differenceOfDate)"
}



func showToastFinish(controller: UIViewController,message : String) {
    
    let toastLabel = UILabel(frame: CGRect(x: controller.view.frame.size.width/2 - 75, y: controller.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = .center;
    toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    controller.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 1.0, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
        controller.navigationController?.popViewController(animated: true)
    })
    
    
  
}
