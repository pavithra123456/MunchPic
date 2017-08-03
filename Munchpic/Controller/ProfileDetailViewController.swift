//
//  ProfileDetailViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 06/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire


class ProfileDetailViewController: UIViewController ,UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var scrollview: UIScrollView!
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
    
    
    @IBOutlet weak var profilePicBtn: UIButton!
    
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
                        if let img = UIImage(data: data) {
                             self.userPic.image =  img
                            self.userPic.image = UIImage(data: data)
                            self.userPic.layoutIfNeeded()
                            self.userPic.layer.cornerRadius = self.userPic.frame.size.width/2
                            self.userPic.layer.masksToBounds = true
                        }
                        
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
        malebtn.isUserInteractionEnabled = false
        femalebtn.isUserInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        scrollview.isScrollEnabled = true
        scrollview.contentSize = CGSize(width: scrollview.contentSize.width, height: scrollview.contentSize.height)
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
            profilePicBtn.isUserInteractionEnabled = true
            malebtn.isUserInteractionEnabled = true
            femalebtn.isUserInteractionEnabled = true

             scrollview.contentSize = CGSize(width: scrollview.contentSize.width, height: scrollview.contentSize.height+200)
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
                    
                    if(self.genderstring == "male"){
                        
                        self.malebtn.setImage(UIImage(named : "rd2.png"), for: UIControlState.normal)
                        self.femalebtn.setImage(UIImage(named : "rd1.png"), for: UIControlState.normal)
                        
                    }else if(self.genderstring == "female"){
                        
                        self.malebtn.setImage(UIImage(named : "rd1.png"), for: UIControlState.normal)
                        self.femalebtn.setImage(UIImage(named : "rd2.png"), for: UIControlState.normal)
                        
                    }else{
                        
                        self.malebtn.setImage(UIImage(named : "rd1.png"), for: UIControlState.normal)
                        self.femalebtn.setImage(UIImage(named : "rd1.png"), for: UIControlState.normal)
                    }
                    
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
        
            
         parametersstring = "userId=\(uId)" + "&name=\(name)" + "&dob=\(dob)" + "&gender=\(genderstring)"  + "&country=\(country)" + "&state=\(state)" + "&city=\(city)" + "&email=\(email)" + "&mobile=\(mobile)" + "&about=\(about)"
            
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

        var url = URLRequest(url: URL(string: Constants.kBaseUrl + Constants.KUpdateUserInfo)!)
        url.httpMethod = "POST"

        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if(self.userPic.image == nil){
                
                print("pic is nil")
                
            }else{
                
                 multipartFormData.append(UIImagePNGRepresentation(self.userPic.image!)!, withName: "image", fileName: "imageFileName.jpg", mimeType: "image/jpeg")
            }
            
           
            multipartFormData.append((email.data(using: String.Encoding.utf8)!), withName: "email")
            multipartFormData.append((name.data(using: String.Encoding.utf8)!), withName: "name")
            multipartFormData.append((dob.data(using: String.Encoding.utf8)!), withName: "dob")
            multipartFormData.append((country.data(using: String.Encoding.utf8)!), withName: "country")
            multipartFormData.append((state.data(using: String.Encoding.utf8)!), withName: "state")
            multipartFormData.append((city.data(using: String.Encoding.utf8)!), withName: "city")
            multipartFormData.append((mobile.data(using: String.Encoding.utf8)!), withName: "mobile")
            multipartFormData.append((about.data(using: String.Encoding.utf8)!), withName: "about")
            
        }, with: url, encodingCompletion: { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseString(completionHandler: { (responseString) in
                    print(responseString.description)
                    if responseString.description == "Registered Successfully!, Please check your mail for activation!"{
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "ShowDashboard", sender: nil)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        Utility.showAlert(title: "MunchPic", message: responseString.description as String, controller: self,completion:nil)
                        self.getProfileDetails()
                    }
                })
            case .failure(let encodingError):
                print(encodingError)
            }
            
        });
        
        
       
    }
    
    //MARK: -  Iamge Picker
    @IBAction func profilePicBtnAction(_ sender: Any) {
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

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
        
        [String : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(kUTTypeImage as NSString) {
            let image = info[UIImagePickerControllerOriginalImage]as! UIImage
            // profilepic.image = image
            
            self.userPic.image = image
            //  imagesarray.insert(image, at: indexval)
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
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
