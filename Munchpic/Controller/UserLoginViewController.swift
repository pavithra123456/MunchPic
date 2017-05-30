//
//  UserLoginViewController.swift
//  HNlogin
//
//  Created by ypomacmini on 29/05/17.
//  Copyright © 2017 YourPracticeOnline. All rights reserved.
//

import UIKit

class UserLoginViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet var password: UITextField!
    @IBOutlet var emailid: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

     // MARK: - Check validations
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == emailid){
            password.becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        
        return true
    }

     // MARK: - Call login
    
    @IBAction func Login_Action(_ sender: Any) {
        
        if(emailid.text?.characters.count == 0 && password.text?.characters.count == 0){
            
            _ = SweetAlert().showAlert("Alert!", subTitle: "Please fill all the feilds", style: AlertStyle.none)
            
        }else if(emailid.text?.characters.count == 0 ){
            
             _ = SweetAlert().showAlert("Alert!", subTitle: "Please enter your registered Emailid", style: AlertStyle.none)
            
        }else if(password.text?.characters.count == 0 ){
            
              _ = SweetAlert().showAlert("Alert!", subTitle: "Please enter your password", style: AlertStyle.none)
            
        }else{
            
           
            
            if Reachability.isConnectedToNetwork() == true {
                
                 // call login api
                
                _ = SweetAlert().showAlert("Alert!", subTitle: "You are logged in successfully!", style: AlertStyle.success)
                
            }else{
                
                let alert = UIAlertController(title: "Alert!", message: "Please check your internet connection", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }

    @IBAction func ForgetPAssword(_ sender: Any) {
        
        let alertController = UIAlertController(title: "", message: "Please enter your email", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                
                /*
                 // store your data
                 if(field.text?.characters.count == 0){
                 
                 self.alertmsgstring = "Feild should not be nil"
                 self.alertstring(messagestring: self.alertmsgstring)
                 
                 }else{
                 
                 UserDefaults.standard.set(field.text, forKey: "userEmail")
                 UserDefaults.standard.synchronize()
                 }
                 
                 */
                
            } else {
                
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
        
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

