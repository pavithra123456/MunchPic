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
import MBProgressHUD


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
    @IBOutlet weak var countryButton: UIButton!
    var tapguesture : UITapGestureRecognizer?
    
    let countriesarray = ["India","Pakisthan","Srilanka","Bangladesh","Nepal","Tibet","China","Afghanisthan","Australia","Russia","UK","USA","Africa","France"]

    
    @IBOutlet weak var countryTableview: UITableView!
    @IBOutlet weak var profilePicBtn: UIButton!
    
    var genderstring = NSString()
    
    var pickerView:UIView = UIView()
    var datePicker:UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getProfileDetails()
        self.nameTxtField.delegate = self
        self.countryTableview.dataSource = self
        self.countryTableview.delegate = self

        
        self.userPic.layoutIfNeeded()
        self.userPic.layer.cornerRadius = self.userPic.frame.size.width/2
        self.userPic.layer.masksToBounds = true
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let imgrl = "http://ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(String(describing: userId))/user.jpg"
            URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let data =  data1 {
                        if let img = UIImage(data: data) {
                             self.userPic.image =  img
                            self.userPic.image = UIImage(data: data)
                            
                        }
                        
                    }
                })
                }.resume()
            
        }
        
        nameTxtField.isUserInteractionEnabled = false
        aboutTxtField.isUserInteractionEnabled = false
        dobTxtField.isUserInteractionEnabled = false
        stateTxtField.isUserInteractionEnabled = false
        cityTxtField.isUserInteractionEnabled = false
        phoneNoTxtField.isUserInteractionEnabled = false
        emailTxtField.isUserInteractionEnabled = false
        malebtn.isUserInteractionEnabled = false
        femalebtn.isUserInteractionEnabled = false
        countryTxtField.isUserInteractionEnabled = false

        countryButton.isEnabled = false
        countryTableview.isHidden = true
        
        addGuestures()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(ProfileDetailViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(ProfileDetailViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        
    }

   
   
    
//    func keyboardWillShow(_ notification: Notification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            // keyboardHeight = keyboardRectangle.height
//            self.scrollview.contentOffset.y =  self.scrollview.contentOffset.y + keyboardRectangle.height
//        }
//    }
//    
//    func keyboardWillHide(_ notification: Notification) {
//        
//        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            // keyboardHeight = keyboardRectangle.height
//            self.scrollview.contentOffset.y =  self.scrollview.contentOffset.y - keyboardRectangle.height
//        }
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidLayoutSubviews() {
//        
//            scrollview.isScrollEnabled = true
//            scrollview.contentSize = CGSize(width: scrollview.contentSize.width, height: scrollview.contentSize.height)
//       
//        
//    }

    func addGuestures() {
        tapguesture = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
        tapguesture?.isEnabled = true
        scrollview.addGestureRecognizer(tapguesture!)
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
            scrollview.isScrollEnabled = true
            
           // scrollview.contentSize = CGSize(width: scrollview.contentSize.width, height: scrollview.contentSize.height + 200)
            nameTxtField.isUserInteractionEnabled = true
            aboutTxtField.isUserInteractionEnabled = true
            dobTxtField.isUserInteractionEnabled = true
            stateTxtField.isUserInteractionEnabled = true
            cityTxtField.isUserInteractionEnabled = true
            phoneNoTxtField.isUserInteractionEnabled = true
            emailTxtField.isUserInteractionEnabled = true
            profilePicBtn.isUserInteractionEnabled = true
            malebtn.isUserInteractionEnabled = true
            femalebtn.isUserInteractionEnabled = true
            countryButton.isEnabled = true

            
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
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
           
            ServiceLayer.getusetInfo(forUserID: userId as! String , completion: { (respose, status, msg) in
                
                print(respose)
                DispatchQueue.main.async(execute: {
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                })
                
                if respose?.count == 0 {
                    Utility.showAlert(title: "MunchPic", message: "Personal Information cannot retrived.", controller: self, completion:nil)
                    return
                }
                
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
                    self.countryTableview.reloadData()
                    
                    
                    
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
//            
//        LoginServiceLayer().updateUserInfo(parameter:parametersstring  ,completion: { (response, status, message) in
//            
//            if status {
//                
//                let responseArray = response as![ [String:AnyObject]]
//                let responsedict = responseArray[0]
//                
//            }
//            else  {
//                DispatchQueue.main.async {
//                    
//            Utility.showAlert(title: "Alert!", message: message, controller: self,completion:nil)
//             
//                }
//            }
//           
//        })

        var url = URLRequest(url: URL(string: Constants.kBaseUrl + Constants.KUpdateUserInfo)!)
        url.httpMethod = "POST"

        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if(self.userPic.image == nil){
                
                print("pic is nil")
                
            }else{
                
                 multipartFormData.append(UIImagePNGRepresentation(self.userPic.image!)!, withName: "image", fileName: "imageFileName.jpg", mimeType: "image/jpeg")
            }
            
            if let userId =  UserDefaults.standard.value(forKey: "userId") {
                multipartFormData.append(("\(userId)".data(using: String.Encoding.utf8)!), withName: "userId")
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
                    if responseString.description == "SUCCESS: Success!"{
                        DispatchQueue.main.async {
                            Utility.showAlert(title: "Sucess", message: "User info updated.", controller: self, completion: {(action) in
                            self.dismiss(animated: true, completion: nil)
                            })
                        }
                    }

                })
            case .failure(let encodingError):
                print(encodingError)
            }
            
        });
        
        
       
    }
    
    //MARK: -  Iamge Picker
    @IBAction func profilePicBtnAction(_ sender: Any) {
    let actionSheetController = UIAlertController(title: "Upload your photo", message: "", preferredStyle: .actionSheet)
    
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
    
   
    

    //MARK: - Textfielkd Delegates
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollview.contentOffset.y = 0
        
        if textField == countryTxtField {
            self.countryTableview.isHidden = true
            countryTableview.reloadData()
           
        }
        textField.resignFirstResponder()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if(textField == dobTxtField){
            
            textField.resignFirstResponder()
            self.selectdobpicker()
            
        }else if textField == countryTxtField{
            textField.inputView = nil
          
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.countryTableview.isHidden = true
        if(textField == countryTxtField){
                self.hideKeyboard()
        }
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameTxtField{
         aboutTxtField.becomeFirstResponder()
        }else if textField == aboutTxtField{
            textField.resignFirstResponder()
            self.selectdobpicker()
        }else if textField == stateTxtField{
            cityTxtField.becomeFirstResponder()
           
        }else if textField == cityTxtField{
            phoneNoTxtField.becomeFirstResponder()
        }else if textField == phoneNoTxtField{
            emailTxtField.becomeFirstResponder()
        }else if textField == emailTxtField{
            textField.resignFirstResponder()
           
        }else{
            
            textField.resignFirstResponder()
        }

        return true
    }
    
    func hideKeyboard(){
        
        nameTxtField.resignFirstResponder()
        aboutTxtField.resignFirstResponder()
        dobTxtField.resignFirstResponder()
        stateTxtField.resignFirstResponder()
        cityTxtField.resignFirstResponder()
        phoneNoTxtField.resignFirstResponder()
        emailTxtField.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerAutoKeyboard { (result) in
            print("keyboard status \(result.status)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unRegisterAutoKeyboard()
    }


   
    
    @IBAction func showCountryTableview(_ sender: Any) {
        
        tapguesture?.isEnabled = false
        self.hideKeyboard()
        scrollview.isScrollEnabled = false
        countryTableview.isHidden = false
        countryTableview.reloadData()

        
    }
    
    
    func selectdobpicker(){
        
        
        scrollview.isScrollEnabled = false
        pickerView.removeFromSuperview()
        
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            // Ipad
            if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation))
            {
                // mscrollview .scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
                datePicker.frame = CGRect(x: 0,y: 44,width: self.view.frame.size.width,height: 250)
                pickerView.frame = CGRect(x: 0, y: self.view.frame.size.height-300, width: self.view.frame.size.width, height: 200)
                
            }else{
                // mscrollview .scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
                datePicker.frame = CGRect(x: 0,y: 44,width: self.view.frame.size.width,height: 250)
                pickerView.frame = CGRect(x: 0, y: self.view.frame.size.height-300, width: self.view.frame.size.width, height: 200)
                
            }
            
        }
        else
        {
            // Iphone
            if(UIDeviceOrientationIsLandscape(UIDevice.current
                .orientation))
            {
                //  mscrollview .scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
                datePicker.frame = CGRect(x: 0,y: 44,width: self.view.frame.size.width,height: 200)
                pickerView.frame = CGRect(x: 0, y: self.view.frame.size.height - 200, width: self.view.frame.size.width, height: 200)
            }else{
                // mscrollview .scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
                datePicker.frame = CGRect(x: 0,y: 44,width: self.view.frame.size.width,height: 180)
                pickerView.frame = CGRect(x: 0, y: self.view.frame.size.height-220, width: self.view.frame.size.width, height: 200)
                
            }
        }
        
        
        pickerView.backgroundColor = UIColor.white
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.backgroundColor = UIColor.white
        datePicker.date = NSDate() as Date
        
        //datePicker.tag = (sender as AnyObject).tag
        
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0,y: 0,width: pickerView.frame.size.width,height: 44)
        toolbar.barStyle = UIBarStyle.blackTranslucent;
        //toolbar.backgroundColor = [UIColor whiteColor];
        
        let flexibleSpaceLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelbtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RegistrationViewController.cancelbutton(sender:)))
        cancelbtn.tintColor = UIColor.white
        //cancelbtn.tag = (sender as AnyObject).tag
        
        let donebtn = UIBarButtonItem(title: "Done", style: .plain, target: self,action:#selector(RegistrationViewController.donebutton(sender:)))
        donebtn.tintColor = UIColor.white
        
        //donebtn.tag = (sender as AnyObject).tag
        
        
        let toolbarButtonItems = [
            cancelbtn,
            flexibleSpaceLeft,
            donebtn
        ]
        toolbar.setItems(toolbarButtonItems, animated: true)
        
        
        pickerView .addSubview(toolbar)
        pickerView .addSubview(datePicker)
        self.view.addSubview(pickerView)
        
    }
    
    
    func cancelbutton(sender: UIBarButtonItem) {
        
        pickerView.removeFromSuperview()
        scrollview.isScrollEnabled = true
    }
    
    func donebutton(sender: UIBarButtonItem) {
        LabelTitle(sender: sender)
        pickerView.removeFromSuperview()
        scrollview.isScrollEnabled = true
    }
    
    
    
    func LabelTitle(sender: AnyObject) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        dateFormatter.dateFormat = "d-MMM-yyy"
        
        let value:NSString =  dateFormatter .string(from: datePicker.date) as NSString
        let currDate = NSDate()
        let newDate =  dateFormatter .string(from: currDate as Date)
        
        let date1:NSDate = dateFormatter .date(from: value as String)! as NSDate
        let date2:NSDate = dateFormatter .date(from: newDate)! as NSDate
        
        
        let dateComparisionResult:ComparisonResult = date1.compare(date2 as Date)
        
        if dateComparisionResult == ComparisonResult.orderedDescending
        {
            
            Utility.showAlert(title: "Warning!", message: "Invalid Date,Please select a valid date.", controller: self,completion:nil)
            
            
        }
            
        else if dateComparisionResult == ComparisonResult.orderedAscending
        {
            
            dobTxtField.text = value as String
        }
            
        else if dateComparisionResult == ComparisonResult.orderedSame
        {
            
            
            dobTxtField.text = value as String
        }
        
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
extension ProfileDetailViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return countriesarray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.countryTableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!

        cell.textLabel?.text = self.countriesarray[indexPath.row] as? String
        cell.textLabel?.textColor = UIColor.black
        cell.backgroundColor = UIColor.white

        if countryTxtField.text == cell.textLabel?.text  {
            cell.backgroundColor = UIColor.red
        }
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         tapguesture?.isEnabled = true
            countryTxtField.text = self.countriesarray[indexPath.row] as? String
            countryTxtField.resignFirstResponder()
           self.countryTableview.isHidden = true
            scrollview.isScrollEnabled = true
    }

}
