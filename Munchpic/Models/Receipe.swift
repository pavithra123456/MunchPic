//
//  Receipe.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class Receipe {
    var id:Int = 0
    var name:String = ""
    var ingredients = [String]()
    var creationDate = Date()
    var author :Profile?
}

class Profile {
    var name:String?
    var phoneNumber:NSNumber?
    var email:String?
    var profilePic:UIImage?
}
