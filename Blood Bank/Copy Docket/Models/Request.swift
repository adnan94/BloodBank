//
//  Request.swift
//  Copy Docket
//
//  Created by Mac on 21/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import CodableFirebase
class Request:Codable{
    var userID:String!
    var id:String!
    var bloodGroup:String!
    var gender:String!
    var completed:Int!
    var timestamp:CLong!
    var expiry:CLong!
    var user:User!

    init(){}
}
