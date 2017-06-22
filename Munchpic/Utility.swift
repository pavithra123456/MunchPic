//
//  Utility.swift
//  Perfometer
//
//  Created by PremP on 29/11/16.
//  Copyright © 2016 opteamix. All rights reserved.
//

import UIKit
import Alamofire



class Utility {
    static let dayTimePeriodFormatter = DateFormatter()

    //  Show alert controller with the given title and message.
  
    
    class func showAlert(title: String, message: String, controller: UIViewController,completion: ((UIAlertAction) ->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: completion))
        controller.present(alert, animated: true, completion: nil)
    }
    
}
