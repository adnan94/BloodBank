//
//  AddRequestViewController.swift
//  Copy Docket
//
//  Created by Mac on 14/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
import JGProgressHUD


class AddRequestViewController:  UIViewController  {
    
    
    
    @IBOutlet weak var maleText: UILabel!
    @IBOutlet weak var femaleText: UILabel!
    @IBOutlet weak var femaleView: CustomRadiusView!
    
    @IBOutlet weak var maleView: CustomRadiusView!
    @IBOutlet weak var date: UITextField!
    
    @IBOutlet weak var buttonOplus: CustomButton!
    @IBOutlet weak var buttonABplus: CustomButton!
    @IBOutlet weak var buttonAplus: CustomButton!
    @IBOutlet weak var buttonAminus: CustomButton!
    @IBOutlet weak var buttonBplus: CustomButton!
    
    @IBOutlet weak var buttonBminus: CustomButton!
    @IBOutlet weak var buttonOminus: CustomButton!
    @IBOutlet weak var buttonABminus: CustomButton!
    
    var gender:String!
    var group:String!
    let datePicker=UIDatePicker()
    var dateValue:CLong!
    var shared:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var hud:JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        
        createDatePicker()
        date.delegate = self
        clicks()
        
    }
    
    
    
    @IBAction func Oneg(_ sender: Any) {
        self.group = "O-"
        buttonABplus.backgroundColor = UIColor.white
        
        buttonABminus.backgroundColor = UIColor.white
        buttonAplus.backgroundColor = UIColor.white
        buttonAminus.backgroundColor = UIColor.white
        buttonBplus.backgroundColor = UIColor.white
        buttonBminus.backgroundColor = UIColor.white
        buttonOplus.backgroundColor = UIColor.white
        buttonOminus.backgroundColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        
        
        buttonABplus.titleLabel?.textColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonABminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBplus.titleLabel?.textColor  =  UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOminus.setTitleColor(UIColor.white, for: .normal)
        
        
        
    }
    
    @IBAction func Opos(_ sender: Any) {
        self.group = "O+"
        buttonABplus.backgroundColor = UIColor.white
        
        buttonABminus.backgroundColor = UIColor.white
        buttonAplus.backgroundColor = UIColor.white
        buttonAminus.backgroundColor = UIColor.white
        buttonBplus.backgroundColor = UIColor.white
        buttonBminus.backgroundColor = UIColor.white
        buttonOplus.backgroundColor =  UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOminus.backgroundColor = UIColor.white
        
        
        buttonABplus.titleLabel?.textColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonABminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOplus.setTitleColor(UIColor.white, for: .normal)
        buttonOminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        
        
        
    }
    @IBAction func Bneg(_ sender: Any) {
        self.group = "B+"
        buttonABplus.backgroundColor = UIColor.white
        
        buttonABminus.backgroundColor = UIColor.white
        buttonAplus.backgroundColor = UIColor.white
        buttonAminus.backgroundColor = UIColor.white
        buttonBplus.backgroundColor = UIColor.white
        buttonBminus.backgroundColor =  UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOplus.backgroundColor = UIColor.white
        buttonOminus.backgroundColor = UIColor.white
        
        
        buttonABplus.titleLabel?.textColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonABminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBplus.titleLabel?.textColor  =  UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBminus.setTitleColor(UIColor.white, for: .normal)
        buttonOplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        
        
        
    }
    
    
    @IBAction func Bpos(_ sender: Any) {
        self.group = "B+"
        buttonABplus.backgroundColor = UIColor.white
        
        buttonABminus.backgroundColor = UIColor.white
        buttonAplus.backgroundColor = UIColor.white
        buttonAminus.backgroundColor = UIColor.white
        buttonBplus.backgroundColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBminus.backgroundColor = UIColor.white
        buttonOplus.backgroundColor = UIColor.white
        buttonOminus.backgroundColor = UIColor.white
        
        
        buttonABplus.titleLabel?.textColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonABminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBplus.setTitleColor(UIColor.white, for: .normal)
        buttonBminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        
        
        
        
    }
    
    
    @IBAction func Aneg(_ sender: Any) {
        
        self.group = "A-"
        buttonABplus.backgroundColor = UIColor.white
        
        buttonABminus.backgroundColor = UIColor.white
        buttonAplus.backgroundColor = UIColor.white
        buttonAminus.backgroundColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBplus.backgroundColor = UIColor.white
        buttonBminus.backgroundColor = UIColor.white
        buttonOplus.backgroundColor = UIColor.white
        buttonOminus.backgroundColor = UIColor.white
        
        
        buttonABplus.titleLabel?.textColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonABminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAminus.setTitleColor(UIColor.white, for: .normal)
        buttonBplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        
        
        
    }
    @IBAction func Apos(_ sender: Any) {
        
        self.group = "A+"
        buttonABplus.backgroundColor = UIColor.white
        
        buttonABminus.backgroundColor = UIColor.white
        buttonAplus.backgroundColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAminus.backgroundColor = UIColor.white
        buttonBplus.backgroundColor = UIColor.white
        buttonBminus.backgroundColor = UIColor.white
        buttonOplus.backgroundColor = UIColor.white
        buttonOminus.backgroundColor = UIColor.white
        
        
        buttonABplus.titleLabel?.textColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonABminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAplus.setTitleColor(UIColor.white, for: .normal)
        buttonAminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        
    }
    @IBAction func ABpos(_ sender: Any) {
        
        self.group = "AB+"
        buttonABplus.backgroundColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonABminus.backgroundColor = UIColor.white
        buttonAplus.backgroundColor = UIColor.white
        buttonAminus.backgroundColor = UIColor.white
        buttonBplus.backgroundColor = UIColor.white
        buttonBminus.backgroundColor = UIColor.white
        buttonOplus.backgroundColor = UIColor.white
        buttonOminus.backgroundColor = UIColor.white
        
        
        buttonABplus.setTitleColor(UIColor.white, for: .normal)
        buttonABminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        
    }
    @IBAction func ABneg(_ sender: Any) {
        
        self.group = "AB-"
        buttonABplus.backgroundColor = UIColor.white
        buttonABminus.backgroundColor = UIColor(red: 0.7098,green: 0.1725 , blue: 0.1725, alpha: 1);        buttonAplus.backgroundColor = UIColor.white
        buttonAminus.backgroundColor = UIColor.white
        buttonBplus.backgroundColor = UIColor.white
        buttonBminus.backgroundColor = UIColor.white
        buttonOplus.backgroundColor = UIColor.white
        buttonOminus.backgroundColor = UIColor.white
        
        
        buttonABplus.titleLabel?.textColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        
        buttonABminus.setTitleColor(UIColor.white, for: .normal)
        buttonAplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonAminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonBminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOplus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        buttonOminus.titleLabel?.textColor  = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
        
        
    }
    
    
    @IBAction func updateButton(_ sender: Any) {
        if self.shared.user!.profileCompleted{
         
            var flag:Bool = true
            
            if dateValue == nil{
                flag = false
                toast(controller: self, message: "Select Date", seconds: 1.0)
            }
            else  if gender == nil{
                flag = false
                toast(controller: self, message: "Select Gender", seconds: 1.0)
            } else  if group == nil{
                flag = false
                toast(controller: self, message: "Select Group", seconds: 1.0)
            }
            
            if flag {
             checkForContinue()
            }
        }

    }
   
}


extension AddRequestViewController :  UITextFieldDelegate {
  
    func checkForContinue(){
       self.hud.show(in: self.view)
     
        ref.child("Requests").queryOrdered(byChild: "userID").queryEqual(toValue:shared.user!.id).queryLimited(toLast: 1).observeSingleEvent(of: .value, with: { snapshot in
            
            if snapshot.exists() {
               
                for item in snapshot.children{
               
                    var datashot:DataSnapshot = item as! DataSnapshot
                   
                    var request:Request = try! FirebaseDecoder().decode(Request.self, from: datashot.value!)
                    
                    
                     print(datashot.value!)
                    
                    if request.bloodGroup!.elementsEqual(self.group!) && request.gender!.elementsEqual(self.gender!) && request.expiry < currentTimeInMilli(){
                        
                        self.sentRequest()
                    }else{
                        toast(controller: self, message: "Request With These Fields Already Available", seconds: 1.0)
                    }
                    
                    self.hud.dismiss()
                    
                }
            }else{
                self.sentRequest()
                self.hud.dismiss()
            }
            
            })
    }
    
    func sentRequest(){
        var request:[String:Any] = [:]
        var push:String = ref.childByAutoId().key!
        
        request["userID"] = self.shared.user!.id!
        request["id"] = push
        request["bloodGroup"] = self.group
        request["gender"] = self.gender
        request["completed"] = 0
        request["timestamp"] = ServerValue.timestamp()
        request["expiry"] = self.dateValue
        ref.child("Requests").child(push).setValue(request, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print("\(error!.localizedDescription)")
            } else {
                self.hud.dismiss()
                self.navigationController?.popViewController(animated: true)
                toast(controller: self, message: "Request Sucessfull", seconds: 1.5)
            }
        })
    }
    func clicks(){
        let femaleClicked = UITapGestureRecognizer(target: self, action:  #selector(femaleClicked(sender:)))
        self.femaleView.addGestureRecognizer(femaleClicked)
        
        let maleClicked = UITapGestureRecognizer(target: self, action:  #selector(maleClicked(sender:)))
        self.maleView.addGestureRecognizer(maleClicked)
        
    }
    
    @objc func femaleClicked(sender : UITapGestureRecognizer) {
        self.femaleView.backgroundColor =  UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        self.femaleText.textColor = UIColor.white
        
        self.maleView.backgroundColor = UIColor.white
        self.maleText.textColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        
        self.gender = "Female"
    }
    
    @objc func maleClicked(sender : UITapGestureRecognizer) {
        self.maleView.backgroundColor =  UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        self.maleText.textColor = UIColor.white
        
        self.femaleView.backgroundColor = UIColor.white
        self.femaleText.textColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
        self.gender = "Male"
        
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.date.isUserInteractionEnabled = false
        self.date.isEnabled = false
        return true
    }
    
    
    
    func createDatePicker(){
        
        ///toolbar
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        
        //done button for toolbar
        let done=UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneEdit))
        toolbar.setItems([done], animated: false)
        date.inputAccessoryView = toolbar
        date.inputView = self.datePicker
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .dateAndTime
        
    }
    
    
    @objc func doneEdit(){
        let formatter=DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let dateString=formatter.string(from: datePicker.date)
        date.text = dateString
        self.dateValue = CLong((datePicker.date.timeIntervalSince1970) * 1000)
        self.date.isUserInteractionEnabled = true
        self.date.isEnabled = true
        
        self.view.endEditing(true)
        
    }
}


