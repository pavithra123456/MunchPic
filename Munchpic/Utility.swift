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
    
    
    var borderColor : UIColor? {
        get {
            if let cgcolor = layer.borderColor {
                return UIColor(cgColor: cgcolor)
            } else {
                return nil
            }
        }
        set {
            layer.borderColor = newValue?.cgColor
            
            // width must be at least 1.0
            if layer.borderWidth < 1.0 {
                layer.borderWidth = 1.0
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
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
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 6 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            
            //            let position = self.position(from: self.beginningOfDocument, offset: 3)!
            //            self.selectedTextRange = self.textRange(from: position, to: position)
        }
    }
    
    @IBInspectable var roundedBorder: Bool = true {
        didSet {
            self.layer.borderWidth = 1
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            
            //            let position = self.position(from: self.beginningOfDocument, offset: 3)!
            //            self.selectedTextRange = self.textRange(from: position, to: position)
        }
    }

    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hexColor:Int) {
        self.init(red:(hexColor >> 16) & 0xff, green:(hexColor >> 8) & 0xff, blue:hexColor & 0xff)
    }
    
    static func placeHolderLabelColor() -> UIColor {
        return UIColor.black//(red: 83/255.0, green: 83/255.0, blue: 83/255.0, alpha: 1.0)
    }
    
}

