//
//  SingleMessage.swift
//  Copy Docket
//
//  Created by Mac on 21/04/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import CodableFirebase


class SingleMessage:Codable{
    var message:String!
    var timestamp:CLong!
    var id:String!
    var name:String!
    var messageId:String!
}
