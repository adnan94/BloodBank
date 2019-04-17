//
//  User.swift
//  Fizyo
//
//  Created by Adnan Ahmed on 28/11/2018.
//  Copyright © 2018 RevolutionaryTechnologies. All rights reserved.
//

import Foundation
import CodableFirebase

class User:Codable{
    var name:String
    var email:String
    var number:String
    var type:Int
    var picUrl:String?
    var emailVerified:Int?
    var password:String?
    var active:Int?
    var date:CLong?
    var deviceID:String?
    var id:String
    var paymentType:Int?
    var planStartDate:CLong?
    var planExpiryDate:CLong?
    var count:Int?
    var totalLinks:Int?
    var used:Int!
    
    init(name:String,
    email:String,
    number:String,
     type:Int,
     picUrl:String,
     emailVerified:Int,
     password:String,
     flag:Bool,
     active:Int,
     date:CLong,
    deviceID:String
        ,id:String,used:Int
){
        self.name = name
        self.email = email
        self.number = number
        self.type = type
        self.picUrl = picUrl
        self.emailVerified = emailVerified
        self.password = password
        self.active = active
        self.date = date
        self.deviceID = deviceID
        self.id = id
        self.used = used
    }
   
    init(name:String,
         email:String,
         number:String,
         type:Int,
         picUrl:String,
         emailVerified:Int,
         password:String,
         flag:Bool,
         active:Int,
         date:CLong,
         deviceID:String
        ,id:String
        ,paymentType:Int
        ,planStartDate:CLong
        , planExpiryDate:CLong,count:Int
        ,totalLinks:Int,used:Int
    
        ){
        self.name = name
        self.email = email
        self.number = number
        self.type = type
        self.picUrl = picUrl
        self.emailVerified = emailVerified
        self.password = password
        self.active = active
        self.date = date
        self.deviceID = deviceID
        self.id = id
        self.paymentType = paymentType
        self.planStartDate = planStartDate
        self.planExpiryDate = planExpiryDate
        self.count = count
        self.totalLinks = totalLinks
    self.used = used
    }
    
    
    init(shot: [String:Any]?){
        self.name = shot!["name"] as! String
        self.email = shot!["email"] as! String
        self.number = shot!["number"] as! String
        self.type = shot!["type"] as!  Int
        self.date = shot!["date"] as! CLong
        self.id = shot!["id"] as! String
        
       
        
        
        if let planStartDate =  shot?["planStartDate"]{
            self.planStartDate = planStartDate as! CLong
        }else{
            self.planStartDate = 0
        }
        
        if let used =  shot?["used"]{
            self.used = used as! Int
        }else{
            self.used = 0
        }
        
        if let planExpiryDate =  shot?["planExpiryDate"]{
            self.planExpiryDate = planExpiryDate as! CLong
        }else{
            self.planExpiryDate = 0
        }
        
        if let active =  shot?["active"]{
            self.active = active as! Int
        }else{
            self.active = 0
        }
       
        
        
        if let emailVerified =  shot?["emailVerified"]{
            self.emailVerified = emailVerified as! Int
        }else{
            self.emailVerified = 0
        }
        
        if let paymentType =  shot?["paymentType"]{
            self.paymentType = paymentType as! Int
        }else{
            self.paymentType = 0
        }
        if let count =  shot?["count"]{
            self.count = count as! Int
        }else{
            self.count = 0
        }
        
        if let count =  shot?["totalLinks"]{
            self.totalLinks = count as! Int
        }else{
            self.totalLinks = 0
        }
        if let picUrl =  shot?["picUrl"]{
            self.picUrl = picUrl as! String
        }else{
            self.picUrl = "N/A"
        }

        if let password =  shot?["password"]{
            self.password = password as! String
        }else{
            self.password = "N/A"
        }
        
            if let deviceId =  shot?["deviceID"]{
                self.deviceID = deviceId as! String
            }else{
                self.deviceID = "N/A"
            }
        
        
    }

    
    
    
    
    
    
}
