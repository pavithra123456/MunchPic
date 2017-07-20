//
//  ProfileDetailViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 06/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var aboutTxtField: UITextField!
    @IBOutlet weak var dobTxtField: UITextField!
    @IBOutlet weak var countryTxtField: UITextField!
    @IBOutlet weak var stateTxtField: UITextField!
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var phoneNoTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet var malebtn: UIButton!
    @IBOutlet var femalebtn: UIButton!
    @IBOutlet weak var userPic: UIImageView!
    
    
    var genderstring = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getProfileDetails()
        self.nameTxtField.delegate = self

        
        
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let imgrl = "http://ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(String(describing: userId))/user.jpg"
            URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let data =  data1 {
                        self.userPic.image = UIImage(data: data)
                        self.userPic.layoutIfNeeded()
                        self.userPic.layer.cornerRadius = self.userPic.frame.size.width/2
                        self.userPic.layer.masksToBounds = true
                    }
                })
                }.resume()
            
            
        }
        
        nameTxtField.isUserInteractionEnabled = false
        aboutTxtField.isUserInteractionEnabled = false
        dobTxtField.isUserInteractionEnabled = false
        countryTxtField.isUserInteractionEnabled = false
        stateTxtField.isUserInteractionEnabled = false
        cityTxtField.isUserInteractionEnabled = false
        phoneNoTxtField.isUserInteractionEnabled = false
        emailTxtField.isUserInteractionEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - mail button selected
    @IBAction func malebtn_Action(_ sender: Any) {
        
        genderstring = "male"
        malebtn.setImage(UIImage(named : "rd2.png"), for: UIControlState.normal)
        femalebtn.setImage(UIImage(named : "rd1.png"), for: UIControlState.normal)
    }
    
    // MARK: - femail button selected
    @IBAction func Femalebtn_Action(_ sender: Any) {
        
        genderstring = "female"
        malebtn.setImage(UIImage(named : "rd1.png"), for: UIControlState.normal)
        femalebtn.setImage(UIImage(named : "rd2.png"), for: UIControlState.normal)
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        if sender.currentTitle == "EDIT" {
            sender.setTitle("UPDATE", for: .normal)
            
            nameTxtField.isUserInteractionEnabled = true
            aboutTxtField.isUserInteractionEnabled = true
            dobTxtField.isUserInteractionEnabled = true
            countryTxtField.isUserInteractionEnabled = true
            stateTxtField.isUserInteractionEnabled = true
            cityTxtField.isUserInteractionEnabled = true
            phoneNoTxtField.isUserInteractionEnabled = true
            emailTxtField.isUserInteractionEnabled = true

        }
            
        else {
            // call update api
            
            self.Updateuserprofile()
        }
        
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getProfileDetails() {
        
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            ServiceLayer.getusetInfo(forUserID: userId as! String , completion: { (respose, status, msg) in
                DispatchQueue.main.async {
                    self.nameTxtField.text = respose?[0]["name"] as? String
                    self.aboutTxtField.text = respose?[0]["about"] as? String
                    self.dobTxtField.text = respose?[0]["dob"] as? String
                    self.countryTxtField.text = respose?[0]["country"] as? String
                    
                    self.stateTxtField.text = respose?[0]["state"] as? String
                    self.cityTxtField.text = respose?[0]["city"] as? String
                    
                    self.phoneNoTxtField.text = respose?[0]["mobile"] as? String
                    self.emailTxtField.text = respose?[0]["email"] as? String
                    self.genderstring = (respose?[0]["gender"])! as! NSString
                }


            })
            
        }

    }
    
    func Updateuserprofile(){
        
        
         let userId =  UserDefaults.standard.value(forKey: "userId")
            
        var parametersstring = " "
        
        let uId = userId as! String
        let name = nameTxtField.text! as String
        let dob = dobTxtField.text! as String
        let country = countryTxtField.text! as String
        let state = stateTxtField.text! as String
        let city = cityTxtField.text! as String
        let email = emailTxtField.text! as String
        let mobile = phoneNoTxtField.text! as String
        let about = aboutTxtField.text! as String
        
            
         parametersstring = "userId=\(uId)" + "&name=\(name)" + "&dob=\(dob)" + "&gender=\(genderstring)"  + "&country=\(country)" + "&state=\(state)" + "&city=\(city)" + "email=\(email)" + "&mobile=\(mobile)" + "&about=\(about)"
            
        LoginServiceLayer().updateUserInfo(parameter:parametersstring  ,completion: { (response, status, message) in
            
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

        
        self.getProfileDetails()
       
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

    
    //MARK: - Textfielkd Delegates
    func textFieldDidEndEditing(_ textField: UITextField) {
        
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
