//
//  ResetPasswordViewController.swift
//  Munchpic
//
//  Created by ypo on 20/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var resetkey: UITextField!
    @IBOutlet weak var reenterpassword: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func back_Action(_ sender: Any) {
        
    
    }

    @IBAction func Submit_Action(_ sender: Any) {
        
        var parametersstring = ""
        
        let email = "chaitanyakumari4b5@gmail.com"
        let password = self.password.text! as String
        let resetkeyval = resetkey.text! as String
        
        
        parametersstring = "email=\(email)" + "&activation=\(resetkeyval)" + "&password=\(password)"
        
        LoginServiceLayer().resetPassword(parameter:parametersstring ,completion: { (response, status, message) in
            
            if status {
                
                let responseArray = response as![ [String:AnyObject]]
                let responsedict = responseArray[0]
                
            }
            else  {
                DispatchQueue.main.async {
                    
                    Utility.showAlert(title: "Alert!", message: message, controller: self,completion:nil)
                }
            }
        })

    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
