//
//  User.swift
//  Perfometer
//
//  Created by PremP on 06/12/16.
//  Copyright © 2016 opteamix. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let sharedUserInstance = User()
    
    var firstName : String?
    var lastName : String?
    var supervisorEmail : String?
    var userEmail : String?
    var accessToken : String?
    var usertId = 0
    private override init() {
        
    }
}
