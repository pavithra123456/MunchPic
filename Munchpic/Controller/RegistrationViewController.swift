//
//  RegistrationViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
class RegistrationViewController: UIViewController,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate {
    
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
    
    @IBOutlet weak var countriestable: UITableView!
    @IBOutlet weak var viewconstraint: NSLayoutConstraint!
    var countriesarray = NSMutableArray()
    var statesarray = NSMutableArray()
    var countrystr = NSString()
    var pickerView:UIView = UIView()
    var datePicker:UIDatePicker = UIDatePicker()
    
    
    var genderstring = NSString()
    var checkmarkbool = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mscrollview.delegate = self
        countriestable.isHidden = true
        
        // add default country arrays
        
        countriesarray = ["India","UK","USA","China","Africa","France"]
        statesarray = ["Select State","Andhra pradesh","Karnataka","Goa","Thamil Nadu","Kerala","UP"]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegistrationViewController.hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        mscrollview .addGestureRecognizer(tapGesture)
        
    }
    
    override func viewDidLayoutSubviews() {
        mscrollview.isScrollEnabled = true
        mscrollview.contentSize = CGSize(width: self.view.frame.size.width, height: 1700)
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
        
        if(textField == aboutyou){
            
            aboutyou.resignFirstResponder()
            DOB.becomeFirstResponder()
        }
            
        else if(textField == country){
            
            state.becomeFirstResponder()
            
        }else if( textField == state){
            
            city.becomeFirstResponder()
            
        }else{
            
            textField.resignFirstResponder()
        }
        
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if(textField == country){
            
            countrystr = "country"
            //countryview.isHidden = false
            countriestable.reloadData()
            country.resignFirstResponder()
            countriestable.frame = CGRect(x: textField.frame.origin.x, y: textField.frame.origin.y-10, width: countriestable.frame.width, height: countriestable.frame.height)
            
            countriestable.isHidden = false
            
        }else if( textField == state){
            
            countrystr = "state"
            //countryview.isHidden = false
            countriestable.reloadData()
            state.resignFirstResponder()
            countriestable.frame = CGRect(x: textField.frame.origin.x, y: textField.frame.origin.y-10, width: countriestable.frame.width, height: countriestable.frame.height)
            
            countriestable.isHidden = false
            
            
        }else if( textField == DOB){
            
            textField.resignFirstResponder()
            self.selectdobpicker()
            countriestable.isHidden = true
            
            
        }else{
            
            countriestable.isHidden = true
        }
        
        
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
            
            remembermebtn.setImage(UIImage(named: "uncheckbox@3.png"), for: UIControlState.normal)
            checkmarkbool = true
            
        }else{
             remembermebtn.setImage(UIImage(named: "checkbox@3.png"), for: UIControlState.normal)
            
            checkmarkbool = false
        }
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    @IBAction func termsandconditions(_ sender: Any) {
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit_action(_ sender: Any) {
        
        if(first_name.text?.characters.count == 0||last_name.text?.characters.count == 0||aboutyou.text?.characters.count == 0||DOB.text?.characters.count == 0||city.text?.characters.count == 0||contact_number.text?.characters.count == 0||emailid.text?.characters.count == 0||password.text?.characters.count == 0||reenterpassword.text?.characters.count == 0){
            
            Utility.showAlert(title: "Alert!", message: "please fill all the feilds", controller: self,completion:nil)
            return
            
        }else if((password.text?.characters.count)! < 6){
            
            Utility.showAlert(title: "Alert", message: "Password should be minimum 6 characters", controller: self,completion:nil)
            return
        }
            
        else if(password.text != reenterpassword.text){
            
            Utility.showAlert(title: "Alert", message: "Password and reenterpassword should be same", controller: self,completion:nil)
            return
            
            
        }else if(checkmarkbool == false){
            
            Utility.showAlert(title: "Alert", message: "Please accept the terms and conditions", controller: self,completion:nil)
            return
            
            
        }else{
            
            if isValidEmail(testStr: self.emailid.text!){
                
                print("Validate EmailID")
                
            }else{
                
                Utility.showAlert(title: "Alert", message: "Please enter a valide EmailID", controller: self,completion:nil)
                
            }
            
            // login
            
            if Reachability.isConnectedToNetwork() == true {
                
                var  string =  ""
                
                
                //                let parameter  = ["name":(first_name.text! + " " + last_name.text!),
                //                                  "dob":DOB.text!,
                //                                  "gender":genderstring,
                //                                  "country":country.text!,
                //                                  "state":state.text!,
                //                                  "city":city.text!,
                //                                  "email":emailid.text!,
                //                                  "password":password.text!,
                //                                  "mobile":contact_number.text!,
                //                                  "about":aboutyou.text!
                //                ] as [String : Any]
                
                let email =  self.emailid.text  ??  ""
                let password = self.password.text ?? ""
                let firstName = self.first_name.text ?? ""
                let lastName = self.last_name.text ?? ""
                let dob  = self.DOB.text ?? ""
                let country = self.country.text ?? ""
                let state = self.state.text ?? ""
                let city = self.city.text ?? ""
                let mobile =  self.contact_number.text ?? ""
                let about = self.aboutyou.text ?? ""
                
                
                
                //let email =  emailid.text != nil ? emailid.text : ""
                
                
                string = "email=\(email)" + "&password=\(password)"  + "&name\(firstName + " " + lastName)" + "&dob=\(dob)" + "&country=\(country)" + "&state=\(state)" + "&city=\(city)" + "&mobile=\(mobile)"  + "&about=\(about)" +
                "image\(String(describing: UIImagePNGRepresentation(profilepic.image!)))"
                
                var url = URLRequest(url: URL(string: Constants.kBaseUrl + Constants.KRegister)!)
                url.httpMethod = "POST"
                //url.httpBody = string.data(using: String.Encoding.utf8)
                
                
                
                Alamofire.upload(multipartFormData: { (multipartFormData) in
                    
                    multipartFormData.append(UIImagePNGRepresentation(self.profilepic.image!)!, withName: "image", fileName: "imageFileName.jpg", mimeType: "image/jpeg")
                    multipartFormData.append((email.data(using: String.Encoding.utf8)!), withName: "email")
                    multipartFormData.append((password.data(using: String.Encoding.utf8)!), withName: "password")
                    multipartFormData.append(((firstName + " " + lastName).data(using: String.Encoding.utf8)!), withName: "name")
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
                            }
                        })
                    case .failure(let encodingError):
                        print(encodingError)
                    }
                    
                });
                                
                
                
                /*  LoginServiceLayer.register(relativeUrl: string, completion: { (response, status, msg) in
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
                 self.performSegue(withIdentifier: "ShowDashboard", sender: nil)
                 }
                 }
                 
                 DispatchQueue.main.async {
                 
                 Utility.showAlert(title: "Error", message: msg, controller: self,completion:nil)
                 }
                 }
                 
                 })*/
                
            }
            else{
                
                let alert = UIAlertController(title: "Alert!", message: "Please check your internet connection", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(countrystr == "country"){
            return countriesarray.count
        }else if( countrystr == "state"){
            return statesarray.count
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        self.countriestable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        
        if(countrystr == "country"){
            cell.textLabel?.text = self.countriesarray[indexPath.row] as? String
        }else if( countrystr == "state"){
            cell.textLabel?.text = self.statesarray[indexPath.row] as? String
        }
        
        cell.textLabel?.textColor = UIColor.black
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if(countrystr == "country"){
            
            country.text = self.countriesarray[indexPath.row] as? String
            // countryview.isHidden = true
            country.resignFirstResponder()
            state.becomeFirstResponder()
            
        }else if( countrystr == "state"){
            
            state.text = self.statesarray[indexPath.row] as? String
            // countryview.isHidden = true
            state.resignFirstResponder()
            city.becomeFirstResponder()
        }
        
        
        
    }
    
    
    // selecteing dateofbirth
    
    func selectdobpicker(){
        
        mscrollview.isScrollEnabled = false
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
        mscrollview.isScrollEnabled = true
    }
    
    func donebutton(sender: UIBarButtonItem) {
        LabelTitle(sender: sender)
        pickerView.removeFromSuperview()
        mscrollview.isScrollEnabled = true
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
            
            DOB.text = value as String
        }
            
        else if dateComparisionResult == ComparisonResult.orderedSame
        {
            
            
            DOB.text = value as String
        }
        
    }
    
    func hideKeyboard(){
        
        first_name.resignFirstResponder()
        last_name.resignFirstResponder()
        aboutyou.resignFirstResponder()
        DOB.resignFirstResponder()
        country.resignFirstResponder()
        state.resignFirstResponder()
        city.resignFirstResponder()
        contact_number.resignFirstResponder()
        emailid.resignFirstResponder()
        password.resignFirstResponder()
        reenterpassword.resignFirstResponder()
        
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
