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

@IBDesignable
class CustomTextField : UITextField {
    @IBInspectable var borderColor: UIColor = UIColor.red {
        didSet {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 5
            self.layer.masksToBounds = true
            
//            let position = self.position(from: self.beginningOfDocument, offset: 3)!
//            self.selectedTextRange = self.textRange(from: position, to: position)
        }
    }
     func setCursorPosition(input: UITextField, position: Int) {
            let position = input.position(from: input.beginningOfDocument, offset: position)!
            input.selectedTextRange = input.textRange(from: position, to: position)
        
       
    }
    
}

@IBDesignable
class BorderedView : UIView {
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 5
            self.layer.masksToBounds = true
            
            //            let position = self.position(from: self.beginningOfDocument, offset: 3)!
            //            self.selectedTextRange = self.textRange(from: position, to: position)
        }
    }
    
    @IBInspectable var roundedBorder: Bool = true {
        didSet {
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 6
            self.layer.masksToBounds = true
            
            //            let position = self.position(from: self.beginningOfDocument, offset: 3)!
            //            self.selectedTextRange = self.textRange(from: position, to: position)
        }
    }

    
}
