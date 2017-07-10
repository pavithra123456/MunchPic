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
    
    @IBOutlet weak var userPic: UIImageView!
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func genderBtnAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        }
        else {
            sender.isSelected = true
        }
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        if sender.currentTitle == "EDIT" {
            sender.setTitle("UPDATE", for: .normal)

        }
        else {
            // call update api
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

                }


            })
            
        }

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
