//
//  RegistrationViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import MobileCoreServices

class RegistrationViewController: UIViewController,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate {

    @IBOutlet var first_name: UITextField!
    @IBOutlet var last_name: UITextField!
    @IBOutlet var aboutyou: UITextField!
    @IBOutlet var DOB: UITextField!
    @IBOutlet var country: UITextField!
    @IBOutlet var state: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var contact_number: UITextField!
    @IBOutlet var emailid: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var reenterpassword: UITextField!
    @IBOutlet var malebtn: UIButton!
    @IBOutlet var femalebtn: UIButton!
    @IBOutlet var mscrollview: UIScrollView!
    @IBOutlet var profilepic: UIImageView!
    @IBOutlet var remembermebtn: UIButton!
    
    var genderstring = NSString()
    var checkmarkbool = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        mscrollview.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        mscrollview.isScrollEnabled = true
        mscrollview.contentSize = CGSize(width: self.view.frame.size.width, height: 1500)
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
    
    // MARK: - textfeild delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == first_name){
            last_name.becomeFirstResponder()
        }else if(textField == last_name){
            aboutyou.becomeFirstResponder()
        }else if(textField == aboutyou){
            DOB.becomeFirstResponder()
        }else if(textField == DOB){
            country.becomeFirstResponder()
        }else if(textField == country){
            state.becomeFirstResponder()
        }else if(textField == state){
            city.becomeFirstResponder()
        }else if(textField == city){
            contact_number.becomeFirstResponder()
        }else if(textField == contact_number){
            emailid.becomeFirstResponder()
        }else if(textField == emailid){
            password.becomeFirstResponder()
        }else if(textField == password){
            reenterpassword.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        
        return true
    }

    // MARK: - Takepic action
    
    @IBAction func selectpic_action(_ sender: Any) {
        let actionSheetController = UIAlertController(title: "Uplaod your photo", message: "", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            // Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        
        // From gallery
        let takePicturefromgallert = UIAlertAction(title: "Gallery", style: .default) { action -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(
                UIImagePickerControllerSourceType.savedPhotosAlbum) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.photoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as String]
                imagePicker.allowsEditing = false
                
                DispatchQueue.main.async( execute: {
                    
                    self.present(imagePicker, animated: false,completion: nil)
                    
                    
                })
            }
            
        }
        actionSheetController.addAction(takePicturefromgallert)
        
        // From cam
        let takePicturefromcam = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(
                UIImagePickerControllerSourceType.camera) {
                
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.camera
                
                imagePicker.mediaTypes = [kUTTypeImage as String]
                imagePicker.allowsEditing = false
                
                DispatchQueue.main.async( execute: {
                    
                    self.present(imagePicker, animated: false,completion: nil)
                    
                    
                })
                
                
            }
            
        }
        actionSheetController.addAction(takePicturefromcam)
        
        actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
        
        DispatchQueue.main.async( execute: {
            
            self.present(actionSheetController, animated: true, completion: nil)
            
        })
        
    }
    
    // MARK: - imagepicker delegate
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(kUTTypeImage as NSString) {
            let image = info[UIImagePickerControllerOriginalImage]as! UIImage
            profilepic.image = image
            
            
        }
        
    }
    
    // MARK: - Accept terms and conditions
    
    @IBAction func accept_terms(_ sender: Any) {
        
        if(checkmarkbool == false){
            
            remembermebtn.setImage(UIImage(named: "checkbox@3.png"), for: UIControlState.normal)
            checkmarkbool = true
            
        }else{
            
            remembermebtn.setImage(UIImage(named: "uncheckbox@3.png"), for: UIControlState.normal)
            checkmarkbool = false
        }

    }
    
    @IBAction func termsandconditions(_ sender: Any) {
        
    }
    
    @IBAction func submit_action(_ sender: Any) {
        
        if(emailid.text?.characters.count == 0 && password.text?.characters.count == 0 && reenterpassword.text?.characters.count == 0 && contact_number.text?.characters.count == 0 ){
            
            _ = SweetAlert().showAlert("Alert!", subTitle: "Please fill the mandatory feilds", style: AlertStyle.none)
            
        }else if(password.text != reenterpassword.text){
            
            _ = SweetAlert().showAlert("Alert!", subTitle: "Password and Re-enter password are not same", style: AlertStyle.none)
        }
        else{
            
            // login
            
            if Reachability.isConnectedToNetwork() == true {
                
                let parameter  = ["name":(first_name.text! + " " + last_name.text!),
                                  "dob":DOB.text!,
                                  "gender":genderstring,
                                  "country":country.text!,
                                  "state":state.text!,
                                  "city":city.text!,
                                  "email":country.text!,
                                  "password":password.text!,
                                  "mobile":contact_number.text!,
                                  "about":aboutyou.text!
                ] as [String : Any]
                
                
                LoginServiceLayer.register(parameter: parameter, completion: { (response, status, msg) in
                    
                })
                
                 _ = SweetAlert().showAlert("Alert!", subTitle: "You are registered in successfully!", style: AlertStyle.success)
                
            }else{
                
                let alert = UIAlertController(title: "Alert!", message: "Please check your internet connection", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

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
