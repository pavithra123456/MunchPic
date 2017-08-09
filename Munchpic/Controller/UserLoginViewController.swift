//
//  UserLoginViewController.swift
//  HNlogin
//
//  Created by ypomacmini on 29/05/17.
//  Copyright © 2017 YourPracticeOnline. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Google
import  MBProgressHUD
import SwiftGifOrigin

class UserLoginViewController: UIViewController,UITextFieldDelegate,GIDSignInDelegate,GIDSignInUIDelegate {
    
    
    @IBOutlet var password: UITextField!
    @IBOutlet var emailid: UITextField!
    var gifimageview = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(UserLoginViewController.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        password.delegate = self
        emailid.delegate = self

    }
    
    func methodOfReceivedNotification(notification: Notification){
        
        gifimageview.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: self.view.frame.size.height)
       // view.addSubview(gifimageview)
        UIApplication.shared.keyWindow?.addSubview(gifimageview)
        gifimageview.image = UIImage.gif(name: "Shutter")
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gifDidStop(sender:)), userInfo: nil, repeats: false)
        
        
    }
    
    func gifDidStop(sender: UIImageView) {
        print("gifDidStop")
        gifimageview.isHidden = true
        
    }


     // MARK: - Check validations
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                  textField.resignFirstResponder()

//        if(textField == emailid){
//            password.becomeFirstResponder()
//        }else {
//            textField.resignFirstResponder()
//        }
        
        return true
    }

     // MARK: - Call login
    
    @IBAction func Login_Action(_ sender: Any) {
        

        emailid.text = "chaitanyakumari4b5@gmail.com"
        password.text = "chaithu"
//
        if(emailid.text?.characters.count == 0 && password.text?.characters.count == 0){
            
             Utility.showAlert(title: "Alert", message: "Please fill all the feilds ", controller: self,completion:nil)
            
//            _ = SweetAlert().showAlert("Alert!", subTitle: "Please fill all the feilds", style: AlertStyle.none)
            return
            
        }else if(emailid.text?.characters.count == 0 ){
            
             Utility.showAlert(title: "Alert", message: "Please enter your registered Emailid", controller: self,completion:nil)
            
//            _ = SweetAlert().showAlert("Alert!", subTitle: "Please enter your registered Emailid", style: AlertStyle.none)
            return
            
        }else if(password.text?.characters.count == 0 ){
            
             Utility.showAlert(title: "Alert", message: "Please enter your password", controller: self,completion:nil)
            
//             _ = SweetAlert().showAlert("Alert!", subTitle: "Please enter your password", style: AlertStyle.none)
            
            return
            
        }else{
            
            if Reachability.isConnectedToNetwork() == true {

                
                if let email = emailid.text ,let  pwd = password.text {

                    ServiceLayer.login(relativeUrl:"email=\(email)" + "&password=\(pwd)", completion: { (response, status, message) in
                        if status {
                            let responseArray = response as![ [String:AnyObject]]
                            let responsedict = responseArray[0]
                            
                            if let result = responsedict["userId"] {
                                UserDefaults.standard.set(result, forKey: "userId")
                                UserDefaults.standard.synchronize()
                                
                                User.sharedUserInstance.usertId = Int(result as! String)!
                                
                            }
                            
                            
                            DispatchQueue.main.async {
                                
                                self.performSegue(withIdentifier: "ShowDashboard", sender: nil)
                            }

                        }
                        else  {
                            DispatchQueue.main.async {

                            Utility.showAlert(title: "Error", message: message, controller: self,completion:nil)
                            }
                        }
                    })

                }
                
            }else{
                
                let alert = UIAlertController(title: "Alert!", message: "Please check your internet connection", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }

    @IBAction func ForgotPassword(_ sender: Any) {
        
        let alertController = UIAlertController(title: "", message: "Please enter your email", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                
               
                
            } else {
                
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK: - Facebook Login
    @IBAction func facebookLoginAction(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn([.userFriends, .email, .publicProfile], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print(accessToken)
                print("Logged in!")
                self.fetchProfile()
            }
        }
    }
    
    func fetchProfile() {
        let parameters: [String: Any] = ["fields": "id, name, email, first_name, last_name,gender, picture.width(160).height(160)"]
        let graphReq = GraphRequest(graphPath: "me", parameters: parameters)
        
        graphReq.start { (connection, result) in
            switch result {
            case .failed(let error):
                print(error.localizedDescription)
                return
                
            case .success(let response):
                var email =  response.dictionaryValue?["email"]  as! String
//                email = "pavithra.amc12frfhjbbbhfr@gmail.com"
                MBProgressHUD.showAdded(to: self.view, animated: true)
                self.socialLogin(email: email)
                break
            }
            
        }
    }
    
   func socialLogin(email:String)
   {
    ServiceLayer.login(relativeUrl:"email=\(email)" + "&password=bySocialNW", completion: { (response, status, message) in
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        if status {
            let responseArray = response as![ [String:AnyObject]]
            let responsedict = responseArray[0]
            
            if let result = responsedict["userId"] {
                UserDefaults.standard.set(result, forKey: "userId")
                
                User.sharedUserInstance.usertId = Int(result as! String)!
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ShowDashboard", sender: nil)
                }
                
            }
            
            
            
            
        }
        else  {
            if message == "Failure, Please ensure your email verification" {
                self.socialRegisterUser(email: email)
            }
            //                        DispatchQueue.main.async {
            //
            //                            Utility.showAlert(title: "Error", message: message, controller: self,completion:nil)
            //                        }
        }
    })
    }
    
    func socialRegisterUser (email:String) {
        LoginServiceLayer.register(relativeUrl: "email=\(email)", completion: { (response, status, msg) in
            
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            
            if status == true {
                let responseArray = response as![ [String:AnyObject]]
                let responsedict = responseArray[0]
                
                if let result = responsedict["userId"] {
                    UserDefaults.standard.set(result, forKey: "userId")
                    
                    User.sharedUserInstance.usertId = Int(result as! String)!
                    
                }
                
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ShowDashboard", sender: nil)
                }
            }
            else {
                if msg == "Registered Successfully!, Please check your mail for activation!"{
                    DispatchQueue.main.async {
                        self.socialLogin(email: email)
                        //self.performSegue(withIdentifier: "ShowDashboard", sender: nil)
                    }
                }
                
                if msg == "This Mail ID already exists!!"{
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "ShowDashboard", sender: nil)
                    }
                }
                
                DispatchQueue.main.async {
                    
                    //Utility.showAlert(title: "Error", message: msg, controller: self,completion:nil)
                }
            }
        })
    }
    
    @IBAction  func googleBtnTapped(_ sender: Any) {
        configureGoogleSignInUI()
        configureGoogleSignIn()
        GIDSignIn.sharedInstance().signIn()
    }
    
    func configureGoogleSignInUI() {
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            GIDSignIn.sharedInstance().signInSilently()
        }
    }
    
    func configureGoogleSignIn() {
        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self // as! GIDSignInDelegate!
        GIDSignIn.sharedInstance().uiDelegate = self //.parentController as! GIDSignInUIDelegate!
        GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            print(error?.localizedDescription ?? "")
            return
        }
        
        var userDict = [String:Any]()
        userDict["id"] = user.userID
        userDict["name"] = user.profile.name
        userDict["email"] = user.profile.email
        
        if GIDSignIn.sharedInstance().currentUser.profile.hasImage {
            let dimension = round(100 * UIScreen.main.scale)
            let imageURL = user.profile.imageURL(withDimension:UInt(Int(dimension)))
            if let profileUrl = imageURL  {
                userDict["profileLogoUrl"] = profileUrl.absoluteString
            }
            
            do {
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        print(userDict)
        var string = ""
        
        if let email = user.profile.email {
            string = "email=\(email)"
            
        }
        
        if let pwd = password.text {
            //string = string + "&password=\(pwd)"
            
        }
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        self.socialLogin(email: user.profile.email)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ForgetPAssword(sender:AnyObject){
        

        let alertController = UIAlertController(title: "", message: "Please enter your email", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
     
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                if let registermail = field.text {
                   
                    
                LoginServiceLayer().forgotPassword(parameter:"email=\(registermail)"  ,completion: { (response, status, message) in
                
                    if(message == "Your password reset link send to your e-mail address."){
                        
                        UserDefaults.standard.set(registermail, forKey: "emailid")
                        self.performSegue(withIdentifier: "resetpassword", sender: self)
                        
                    }else{
                        
                        
                        DispatchQueue.main.async {
                            
                            Utility.showAlert(title: "Alert!", message: message, controller: self,completion:nil)
                        }
                    }
                    
                    
                })
                    
                    
                    self.performSegue(withIdentifier: "resetpassword", sender: self)

                }
                
            } else {
                
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
        
      
        
        
        
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

