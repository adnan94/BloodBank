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
    var name:String!
    var email:String!
    var number:String!
    var type:Int!
    var picUrl:String!
    var emailVerified:Int!
    var password:String!
    var active:Int!
    var date:CLong!
    var deviceID:String!
    var id:String!
    var dateOfBirth:CLong!
    var lastDonated:CLong!
    var bloodGroup:String!
    var gender:String!
    var profileCompleted:Bool!
    var address:String!
    
  
    
}
