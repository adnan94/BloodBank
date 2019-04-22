//
//  ProfileViewController.swift
//  Copy Docket
//
//  Created by Mac on 14/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
import JGProgressHUD

class ProfileViewController: UIViewController  {

   
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var address: UITextField!
    
    
    @IBOutlet weak var maleText: UILabel!
    @IBOutlet weak var femaleText: UILabel!
    @IBOutlet weak var femaleView: CustomRadiusView!
   
    var shared:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
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
    var hud:JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       inits()
        
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
        self.group = "B-"
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
self.hud.show(in: self.view)
        var user = self.shared.user!
        if dateValue > 0{
            user.dateOfBirth = dateValue
        }
        if (name.text?.count)! > 0{
        user.name = self.name.text!
        }
        if (address.text?.count)! > 0{
            user.address = address.text!
        }
            user.gender = gender
            user.bloodGroup = group

        
        
        if dateValue > 0 && user.address.elementsEqual("N/A") == false && user.gender.elementsEqual("N/A") == false && user.bloodGroup.elementsEqual("N/A") == false{
            user.profileCompleted = true
        }
        
        let dict = try! FirebaseEncoder().encode(user)

        ref.child("Users").child(user.id).setValue(dict, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print("\(error!.localizedDescription)")
                self.hud.dismiss()
            } else {
                self.navigationController?.popViewController(animated: true)
                self.hud.dismiss()
                toast(controller: self, message: "Profile Updated", seconds: 1.5)
            }
        })

        
    }
  

}
extension ProfileViewController :  UITextFieldDelegate {
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
    
    
    func inits(){
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        
        self.name.text = self.shared.user?.name
        self.address.text = self.shared.user?.address
        
        if self.shared.user!.dateOfBirth > 0{
            dateValue = self.shared.user!.dateOfBirth
            self.date.text = formaterDate(date: self.shared.user!.dateOfBirth!)
            self.dateValue = self.shared.user!.dateOfBirth!
        }else{
            self.dateValue = 0
        }
        
        self.gender = self.shared.user!.gender
        if self.shared.user!.gender.elementsEqual("Male"){
            self.maleView.backgroundColor =  UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
            self.maleText.textColor = UIColor.white
            
          
        }else if self.shared.user!.gender.elementsEqual("Female"){
            
            self.femaleView.backgroundColor =  UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
            self.femaleText.textColor = UIColor.white
        }
        
        self.group = self.shared.user!.bloodGroup
        if self.shared.user!.bloodGroup.elementsEqual("N/A"){
            self.group = "N/A"
           
        }else if self.shared.user!.bloodGroup.elementsEqual("AB+"){
            self.group = "AB+"
            buttonABplus.backgroundColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
            
            buttonABplus.setTitleColor(UIColor.white, for: .normal)
          
            
        }else if self.shared.user!.bloodGroup.elementsEqual("AB-"){
            self.group = "AB-"
            buttonABminus.backgroundColor = UIColor(red: 0.7098,green: 0.1725 , blue: 0.1725, alpha: 1);
            
            buttonABminus.setTitleColor(UIColor.white, for: .normal)
        }else if self.shared.user!.bloodGroup.elementsEqual("A+"){
            
            self.group = "A+"
            buttonAplus.backgroundColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
            buttonAplus.setTitleColor(UIColor.white, for: .normal)
           
            
        }else if self.shared.user!.bloodGroup.elementsEqual("A-"){
            self.group = "A-"
            buttonAminus.backgroundColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
            
            
            buttonAminus.setTitleColor(UIColor.white, for: .normal)
            
            
        }else if self.shared.user!.bloodGroup.elementsEqual("B+"){
            self.group = "B+"
            buttonBplus.backgroundColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
            
            buttonBplus.setTitleColor(UIColor.white, for: .normal)
            
            
            
        }else if self.shared.user!.bloodGroup.elementsEqual("B-"){
            self.group = "B-"
            buttonBminus.backgroundColor =  UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
            
            
            buttonBminus.setTitleColor(UIColor.white, for: .normal)
       
            
            
        }else if self.shared.user!.bloodGroup.elementsEqual("O+"){
            self.group = "O+"
            buttonOplus.backgroundColor =  UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
            buttonOplus.setTitleColor(UIColor.white, for: .normal)
         
        }else if self.shared.user!.bloodGroup.elementsEqual("O-"){
            self.group = "O-"
            buttonOminus.backgroundColor = UIColor(red: 0.7098, green: 0.1725 , blue: 0.1725, alpha: 1)
           
            buttonOminus.setTitleColor(UIColor.white, for: .normal)
            
            
        }
        
        
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        
        createDatePicker()
        date.delegate = self
        clicks()
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
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
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


