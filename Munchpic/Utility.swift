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

        }
    }
    
    @IBInspectable var roundedBorder: Bool = true {
        didSet {
            self.layer.borderWidth = 1
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            
        }
    }
    
}

class RoundedImage:UIImageView {
    
    convenience init(image1:UIImage) {
        self.init(image: image1)
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 6 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var roundedBorder: Bool = true {
        didSet {
            self.layer.borderWidth = 1
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            
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

@IBDesignable
class Toast : UIView {
    var label :UILabel?
    
    class func showToast(text:String,toView:UIView) {
        
        
        let view = Toast.init(labeltext: text,frame:CGRect(x: toView.frame.size.width/2 - 75 , y: toView.frame.size.height - 150, width: 150, height: 50))
        view.labeltext = text
        view.bordercolor = UIColor.darkGray
        view.cornerRadius = 25
        view.isRounded = true
        
        toView.addSubview(view)
        
    }
    
    convenience  init (labeltext:String,frame:CGRect) {
        self.init(frame: frame ) //CGRect(x: 100, y: 200, width: 200, height: 60))
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //fatalError("init(coder:) has not bee0 0   n implemented")
    }
    
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    @IBInspectable
    var borderWidth:CGFloat = 0.0 {
        didSet {
            
        }
    }
    
    @IBInspectable
    var bordercolor:UIColor = UIColor.darkGray {
        didSet {
            self.layer.backgroundColor = bordercolor.cgColor
        }
    }
    
    @IBInspectable
    var isRounded:Bool = true
    {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable
    var cornerRadius:CGFloat = 0.0 {
        
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable
    var labeltext:String = "No resulkt found " {
        
        didSet {
            if label == nil {
                self.label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/2))
                label?.translatesAutoresizingMaskIntoConstraints = false
                self.contentScaleFactor = 0.2
                self.label?.font = UIFont(name: "Arial", size: 13)
                
                
                // self.fadeOut()
                self.addSubview(label!)
                
                self.perform(#selector(Toast.fadeOut), with: self, afterDelay:1)
                
                
                
                label?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
                label?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            }
            
            label?.text = labeltext
            self.label?.textColor = UIColor.white
        }
    }
    
    func fadeIn() {
        // Move our fade out code from earlier
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: { (action)  in
            self.removeFromSuperview()
        })
    }
}

