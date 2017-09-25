//
//  NewPostViewController.swift
//  NewpostView
//
//  Created by ypomacmini on 13/07/17.
//  Copyright © 2017 YourPracticeOnline. All rights reserved.
//

import UIKit
import MobileCoreServices
import MBProgressHUD

class NewPostViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIScrollViewDelegate,UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var pageimage: UIImageView!
    @IBOutlet var pagecontroller: UIPageControl!
    @IBOutlet var vegandnonvegbtn: UIButton!
    @IBOutlet var veglabel: UILabel!
    
    @IBOutlet var veryeasyBtn: UIButton!
    @IBOutlet var easybtn: UIButton!
    @IBOutlet var mediumBtn: UIButton!
    @IBOutlet var difficultBtn: UIButton!
    @IBOutlet var verudifficultBtn: UIButton!
    var verornonvegbool = Bool()
    var indexval = Int()
    var imagesarray = [AnyObject]()
    var mPosition:Int = Int()
    var myint = Int()
    var index = 0
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    var postIdis = Int()
    var postDetails :[String:AnyObject]?
    var scrollingbool = Bool()
    
    
    
    @IBOutlet var mscrollview: UIScrollView!
    
    @IBOutlet var selectCategory: UITextField!
    @IBOutlet var selectcuisine: UITextField!
    @IBOutlet var step1: UITextField!
    @IBOutlet var step2: UITextField!
    @IBOutlet var setp3: UITextField!
    @IBOutlet var step4: UITextField!
    @IBOutlet var timelabel: UITextField!
    @IBOutlet weak var step5: UITextField!
    
    @IBOutlet weak var step6: UITextField!
    @IBOutlet weak var step7: UITextField!
    @IBOutlet weak var step8: UITextField!
    @IBOutlet weak var step9: UITextField!
    @IBOutlet weak var step10: UITextField!
    @IBOutlet weak var DiscBGView: UIView!
    @IBOutlet weak var BV6: BorderedView!
    @IBOutlet weak var BV7: BorderedView!
    @IBOutlet weak var BV8: BorderedView!
    @IBOutlet weak var BV9: BorderedView!
    @IBOutlet weak var BV10: BorderedView!
    
    @IBOutlet weak var viewheightconstraint: NSLayoutConstraint!
    var downint : Int = 6
    var hconstant :Int = 15
    
    
    @IBOutlet weak var titileTextField: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var categoryview: UIView!
    @IBOutlet weak var categorytable: UITableView!
    var difficulty = 3
    
    var catagoriesarray = NSMutableArray()
    var cuisinearray = NSMutableArray()
    var categorystr = NSString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        self.swipeGestureLeft.addTarget(self, action:#selector(NewPostViewController.handleSwipeLeft(gesture:)))
        self.swipeGestureRight.addTarget(self, action:#selector(NewPostViewController.handleSwipeRight(gesture:)))
        //mscrollview.addGestureRecognizer(self.swipeGestureLeft)
        //mscrollview.addGestureRecognizer(self.swipeGestureRight)
        
        // imagesarray = ["Noimage.png","Noimage.png","Noimage.png"]
        imagesarray = [UIImage(named: "camera_newpost")!,UIImage(named: "camera_newpost")!,UIImage(named: "camera_newpost")!]
        collectionView.reloadData()
        
        // self.navigationItem.leftBarButtonItems = []
        //        self.navigationController?.navigationItem .leftBarButtonItems?.append(UIBarButtonItem(image:  UIImage(named: "btn_hamburger"), style: .plain, target: self, action: nil))
        
        //self.navigationItem.leftBarButtonItem.
  
        
        catagoriesarray = ["Select SubCategory","Break Fast","Lunch","Dinner","Dessert"]
        cuisinearray = ["Select Cuisine","North Indian","Rajasthani","Chinese","South Indian","North_East Indian"]
        
        
        categorytable.layer.borderColor = UIColor.gray.cgColor
        categorytable.layer.borderWidth = 1.0
        categorytable.isHidden = true
        
        if(UserDefaults.standard.bool(forKey: "editvisible") == true){
            
            self.navigationItem.title = "Edit Post"
            MBProgressHUD.showAdded(to: self.view, animated: true)
            ServiceLayer.getPostDetails(forPostId: postIdis) { (responseArray , status, msg) in
                
                DispatchQueue.main.async(execute: {
                    MBProgressHUD.hide(for: self.view, animated: true)
                })
                
                if status == true && (responseArray?.count)! > 0 {
                    self.postDetails = responseArray?[0]
                    
                    DispatchQueue.main.async(execute: {
                        self.UpdateUI()
                    })
                }
            }
        }
        
//        NotificationCenter.default.addObserver(self, selector: #selector(NewPostViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(NewPostViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
  
    
    func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            // keyboardHeight = keyboardRectangle.height
            self.mscrollview.contentOffset.y =  0
            self.mscrollview.contentOffset.y =  self.mscrollview.contentOffset.y + keyboardRectangle.height
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            // keyboardHeight = keyboardRectangle.height
            self.mscrollview.contentOffset.y =  self.mscrollview.contentOffset.y - keyboardRectangle.height
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        
        mscrollview.isScrollEnabled = true
        if(downint>7){
             mscrollview.contentSize = CGSize(width: mscrollview.contentSize.width, height: 1800)
        }else{
             mscrollview.contentSize = CGSize(width: mscrollview.contentSize.width, height: 1500)
        }
    
       
    }
    
    func UpdateUI(){
        
        titileTextField.text = postDetails?["dishName"] as? String
        selectCategory.text = postDetails?["subCategory"] as? String
        selectcuisine.text = postDetails?["cuisine"] as? String
        step1.text = postDetails?["description1"] as? String
        step2.text = postDetails?["description2"] as? String
        setp3.text = postDetails?["description3"] as? String
        step4.text = postDetails?["description4"] as? String
        step5.text = postDetails?["description5"] as? String
        step6.text = postDetails?["description6"] as? String
        step7.text = postDetails?["description7"] as? String
        step8.text = postDetails?["description8"] as? String
        step9.text = postDetails?["description9"] as? String
        step10.text = postDetails?["description10"] as? String
        timelabel.text = postDetails?["duration"] as? String
        veglabel.text = postDetails?["category"] as? String
        
        
        var imgrl = postDetails?["ImagePath1"] as! String
        
        URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                if let data =  data1 {
                    if  let img = UIImage(data: data) {
                        self.imagesarray[0] = img
                    }
                }
            })
            }.resume()
        
         imgrl = postDetails?["ImagePath2"] as! String

        URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                if let data =  data1 {
                   if  let img = UIImage(data: data) {
                         self.imagesarray[1] = img
                    }
                }
            })
            }.resume()
        
        imgrl = postDetails?["ImagePath3"] as! String

        URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                if let data =  data1 {
                    if  let img = UIImage(data: data) {
                         self.imagesarray[2] = img
                    }
                }
            })
            }.resume()
        
       
        collectionView.reloadData()
        
    }
    
    //Left gesture
    func handleSwipeLeft(gesture: UISwipeGestureRecognizer){
        
        if pagecontroller.currentPage < imagesarray.count-1 {
            pagecontroller.currentPage += 1
            pageimage.image = (imagesarray[(pagecontroller.currentPage)] as AnyObject) as? UIImage
            mPosition = pagecontroller.currentPage
            if(pageimage.image == nil){
                pageimage.image = UIImage(named: "Noimage.png")
            }
            
        }else{
            //            pagecontroller.currentPage = 0
            //            pageimage.image = (imagesarray[(pagecontroller.currentPage)] as AnyObject) as? UIImage
            //            mPosition = pagecontroller.currentPage
            
        }
    }
    
    // Right gesture
    func handleSwipeRight(gesture: UISwipeGestureRecognizer){
        
        if pagecontroller.currentPage != 0 {
            pagecontroller.currentPage -= 1
            pageimage.image = (imagesarray[(pagecontroller.currentPage)] as AnyObject) as? UIImage
            mPosition = pagecontroller.currentPage
            
            if(pageimage.image == nil){
                pageimage.image = UIImage(named: "Noimage.png")
            }
            
        }else{
            
            //            pagecontroller.currentPage = imagesarray.count
            //            pageimage.image = (imagesarray[(pagecontroller.currentPage)] as AnyObject) as? UIImage
            //            mPosition = pagecontroller.currentPage
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width, height:  200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
        
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
        let imgView = cell.viewWithTag(1) as! UIImageView
        imgView.image = imagesarray[indexPath.row] as? UIImage
        return cell
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cam1(_ sender: Any) {
        
        self.selectimage(sender)
        indexval = 0
        
    }
    
    @IBAction func cam2(_ sender: Any) {
        self.selectimage(sender)
        indexval = 1
        
    }
    
    @IBAction func cam3(_ sender: Any) {
        self.selectimage(sender)
        indexval = 2
    }
    
    func selectimage(_ sender: Any){
        
        let actionSheetController = UIAlertController(title: "Select source", message: "", preferredStyle: .actionSheet)
        
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
            
            pageimage.image = image
            //  imagesarray.insert(image, at: indexval)
            imagesarray[indexval] =  image
            print("imageinsert at \(imagesarray) at indexof \(indexval)")
            pagecontroller.currentPage = indexval
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: IndexPath(item: indexval, section: 0), at: .left, animated: true)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == titileTextField){
            
            
            self.hidekeyboard()
            selectCategory.becomeFirstResponder()
            
        }else if(textField == selectCategory){
           
            self.hidekeyboard()
            selectcuisine.becomeFirstResponder()
            
        }else if( textField == selectcuisine){
            
            self.hidekeyboard()
            timelabel.becomeFirstResponder()
            
        }else{
            
            textField.resignFirstResponder()
        }
        
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
       
        if(textField == selectCategory){
            self.hidekeyboard()
        }else if( textField == selectcuisine){
            self.hidekeyboard()
        }
        
        return true
    }

    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let pos = self.view.convert(textField.frame.origin, to: self.view)
        print(pos)
       
        if(textField == selectCategory){
            self.hidekeyboard()
            titileTextField.resignFirstResponder()
            categorystr = "selectCategory"
            self.hidekeyboard()
            categorytable.reloadData()
            categorytable.frame = CGRect(x: (textField.superview?.frame.origin.x)!, y: (textField.superview?.frame.origin.y)!-10, width: categorytable.frame.width, height: categorytable.frame.height)
            
            categorytable.isHidden = false
            
            
        }else if( textField == selectcuisine){
            
            categorystr = "selectcuisine"
            self.hidekeyboard()
            categorytable.reloadData()
            //selectcuisine.resignFirstResponder()
            categorytable.frame = CGRect(x: (textField.superview?.frame.origin.x)!, y: (textField.superview?.frame.origin.y)!-10, width: categorytable.frame.width, height: categorytable.frame.height)
            
            categorytable.isHidden = false
            
            
        }else if( textField == step7){
            
            
        }else{
            
            
        }
        
        
    }
    
    func hidekeyboard(){
        
        titileTextField.resignFirstResponder()
        selectCategory.resignFirstResponder()
        selectcuisine.resignFirstResponder()
        timelabel.resignFirstResponder()
        step1.resignFirstResponder()
        step2.resignFirstResponder()
        setp3.resignFirstResponder()
        step4.resignFirstResponder()
        step5.resignFirstResponder()
        step6.resignFirstResponder()
        step7.resignFirstResponder()
        step8.resignFirstResponder()
        step9.resignFirstResponder()
        step10.resignFirstResponder()
    }
    
    
    @IBAction func vegandnonvegbtn_Action(_ sender: Any) {
        
        if(verornonvegbool == false){
            veglabel.text = "Non Veg"
            verornonvegbool = true
            vegandnonvegbtn.setImage(UIImage(named:"Nonveg.png"), for: UIControlState.normal)
        }else{
            veglabel.text = "Veg"
            verornonvegbool = false
            vegandnonvegbtn.setImage(UIImage(named:"veg.png"), for: UIControlState.normal)
        }
    }
    
    @IBAction func veryeasyBtn_Action(_ sender: Any) {
        
        veryeasyBtn.backgroundColor = UIColor(hex: "276C22")
        easybtn.backgroundColor = UIColor(hex: "B8B8B8")
        mediumBtn.backgroundColor = UIColor(hex: "B8B8B8")
        difficultBtn.backgroundColor = UIColor(hex: "B8B8B8")
        verudifficultBtn.backgroundColor = UIColor(hex: "B8B8B8")
        Toast.showToast(text: "Very Easy to prepare", toView: self.view)
        difficulty = 1
        
        
    }
    @IBAction func easybtn_Action(_ sender: Any) {
        
        veryeasyBtn.backgroundColor = UIColor(hex: "276C22")
        easybtn.backgroundColor = UIColor(hex: "2A9024")
        mediumBtn.backgroundColor = UIColor(hex: "B8B8B8")
        difficultBtn.backgroundColor = UIColor(hex: "B8B8B8")
        verudifficultBtn.backgroundColor = UIColor(hex: "B8B8B8")
        Toast.showToast(text: "Easy to prepare", toView: self.view)
        
        difficulty = 2
        
    }
    
    @IBAction func mediumbtn_Action(_ sender: Any) {
        
        veryeasyBtn.backgroundColor = UIColor(hex: "276C22")
        easybtn.backgroundColor = UIColor(hex: "2A9024")
        mediumBtn.backgroundColor = UIColor(hex: "DE763E")
        difficultBtn.backgroundColor = UIColor(hex: "B8B8B8")
        verudifficultBtn.backgroundColor = UIColor(hex: "B8B8B8")
        Toast.showToast(text: "Medium", toView: self.view)
        difficulty = 3
        
        
    }
    
    @IBAction func difficultbtn_Action(_ sender: Any) {
        
        veryeasyBtn.backgroundColor = UIColor(hex: "276C22")
        easybtn.backgroundColor = UIColor(hex: "2A9024")
        mediumBtn.backgroundColor = UIColor(hex: "DE763E")
        difficultBtn.backgroundColor = UIColor(hex: "CF6049")
        verudifficultBtn.backgroundColor = UIColor(hex: "B8B8B8")
        Toast.showToast(text: "Difficult to prepare", toView: self.view)
        difficulty = 4
        
    }
    
    @IBAction func verydifficult_Action(_ sender: Any) {
        
        veryeasyBtn.backgroundColor = UIColor(hex: "276C22")
        easybtn.backgroundColor = UIColor(hex: "2A9024")
        mediumBtn.backgroundColor = UIColor(hex: "DE763E")
        difficultBtn.backgroundColor = UIColor(hex: "CF6049")
        verudifficultBtn.backgroundColor = UIColor(hex: "CF4B49")
        Toast.showToast(text: "Very Difficult to prepare", toView: self.view)
        difficulty = 5
        
    }
    
    
    @IBAction func Back_Action(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addDisc_Action(_ sender: Any) {
        
        
        if(downint>10){
            
            Utility.showAlert(title: "Alert", message: "Maximum 10 Descriptions ", controller: self,completion:nil)
            
        }else{
            
            hconstant = hconstant + 60
            viewheightconstraint.constant = CGFloat(hconstant)
            
            if(downint == 6){
                BV6.isHidden = false
            }else if(downint == 7){
            BV7.isHidden = false
            mscrollview.contentSize = CGSize(width: mscrollview.contentSize.width, height: mscrollview.contentSize.height+300)
                
            }else if(downint == 8){
                BV8.isHidden = false
                
            }else if(downint == 9){
                BV9.isHidden = false
                
            }else if(downint == 10){
                BV10.isHidden = false
                
            }else{
                
            }
            downint = downint+1
            
           
        }
        

        
    }
    
    
    @IBAction func ingrediantsBtn_Avtiom(_ sender: Any) {
        
        if(titileTextField.text?.characters.count == 0){
            
            titileTextField.attributedPlaceholder = NSAttributedString(string: "Please add title",attributes: [NSForegroundColorAttributeName: UIColor.red])
            return
            
        }else if (step1.text?.characters.count == 0){
            
            step1.attributedPlaceholder = NSAttributedString(string: "Please add discription",attributes: [NSForegroundColorAttributeName: UIColor.red])
            return
            
        }else if (step2.text?.characters.count == 0){
            step2.attributedPlaceholder = NSAttributedString(string: "Please add discription",attributes: [NSForegroundColorAttributeName: UIColor.red])
            return
            
        }else if (setp3.text?.characters.count == 0){
            
            setp3.attributedPlaceholder = NSAttributedString(string: "Please add discription",attributes: [NSForegroundColorAttributeName: UIColor.red])
            
            return
        }else if (step4.text?.characters.count == 0){
            
            step4.attributedPlaceholder = NSAttributedString(string: "Please add discription",attributes: [NSForegroundColorAttributeName: UIColor.red])
            
            return
            
            
        }else if (step5.text?.characters.count == 0){
            
            step5.attributedPlaceholder = NSAttributedString(string: "Please add discription",attributes: [NSForegroundColorAttributeName: UIColor.red])
            
            return
            
            
        }
        else if (timelabel.text?.characters.count == 0){
            
            timelabel.attributedPlaceholder = NSAttributedString(string: "Please add time",attributes: [NSForegroundColorAttributeName: UIColor.red])
            
            return
            
        } else{
            
            if (BV6.isHidden == false){
                
                if (step6.text?.characters.count == 0){
                    
                    step6.attributedPlaceholder = NSAttributedString(string: "Please add discription",attributes: [NSForegroundColorAttributeName: UIColor.red])
                    
                    return
                    
                }
                
            }
            
            if (BV7.isHidden == false){
                
                if (step7.text?.characters.count == 0){
                    
                    step7.attributedPlaceholder = NSAttributedString(string: "Please add discription",attributes: [NSForegroundColorAttributeName: UIColor.red])
                    
                    return
                    
                }
                
            }
            if (BV8.isHidden == false){
                
                if (step8.text?.characters.count == 0){
                    
                    step8.attributedPlaceholder = NSAttributedString(string: "Please add discription",attributes: [NSForegroundColorAttributeName: UIColor.red])
                    
                    return
                    
                }
                
            }
            if (BV9.isHidden == false){
                
                if (step9.text?.characters.count == 0){
                    
                    step9.attributedPlaceholder = NSAttributedString(string: "Please add discription",attributes: [NSForegroundColorAttributeName: UIColor.red])
                    
                    return
                    
                }
                
            }
            if (BV10.isHidden == false){
                
                if (step10.text?.characters.count == 0){
                    
                    step10.attributedPlaceholder = NSAttributedString(string: "Please add discription",attributes: [NSForegroundColorAttributeName: UIColor.red])
                    
                    return
                    
                }
                
            }
            
            let dishName = titileTextField.text ?? ""
            let description1 = self.step1.text ?? ""
            let description2 = self.step2.text ?? ""
            let description3 = setp3.text ?? ""
            let description4 = self.step4.text ?? ""
            let description5 = self.step5.text ?? ""
            let description6 = self.step6.text ?? ""
            let description7 = self.step7.text ?? ""
            let description8 = self.step8.text ?? ""
            let description9 = self.step9.text ?? ""
            let description10 = self.step10.text ?? ""
            
            let category = veglabel.text ?? ""
            let subCategory = selectCategory.text ?? ""
            let cuisine = selectcuisine.text ?? ""
            
            var string = ""
            string = "userId=\(38)" + "dishName\(dishName )" +
                "description=\(description1)" +
                "category=\(category)"
                + "subCategory=\(subCategory)" + "cuisine=\(cuisine)"
            
            let post = PostModel()
            post.dishName = dishName
          
            post.descriptionArray.append(description1)
            post.descriptionArray.append(description2)
            post.descriptionArray.append(description3)
            post.descriptionArray.append(description4)
            post.descriptionArray.append(description5)
            post.descriptionArray.append(description6)
            post.descriptionArray.append(description7)
            post.descriptionArray.append(description8)
            post.descriptionArray.append(description9)
            post.descriptionArray.append(description10)

            
            post.category = category
            post.subCategory = subCategory
            post.cuisine = cuisine
            
            post.post1 = imagesarray[0] as? UIImage
            post.post2 = imagesarray[1] as? UIImage
            post.post3 = imagesarray[2] as? UIImage
            
            post.difficulty = "\(difficulty)"
            post.efforts = self.timelabel.text!
            
           
            
            
            
            self.performSegue(withIdentifier: "AddIngredients", sender: post)
            
        }
        
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AddIngredients" {
            let vc =  segue.destination as! AddIngredinentsController
            
            vc .postModel = sender as? PostModel
            
            
            if(UserDefaults.standard.bool(forKey: "editvisible") == true){
                
                vc.postIdis = postIdis
                
            }
            
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(categorystr == "selectCategory"){
            return catagoriesarray.count
        }else if(categorystr == "selectcuisine"){
            return cuisinearray.count
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        self.categorytable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        
        if(categorystr == "selectCategory"){
            cell.textLabel?.text = self.catagoriesarray[indexPath.row] as? String
        }else if(categorystr == "selectcuisine"){
            cell.textLabel?.text = self.cuisinearray[indexPath.row] as? String
        }
        
        cell.textLabel?.textColor = UIColor.black
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if(categorystr == "selectCategory"){
            
            selectCategory.text = self.catagoriesarray[indexPath.row] as? String
            // countryview.isHidden = true
            selectCategory.resignFirstResponder()
            selectcuisine.becomeFirstResponder()
            
        }else if(categorystr == "selectcuisine"){
            
            selectcuisine.text = self.cuisinearray[indexPath.row] as? String
             //countryview.isHidden = true
            selectcuisine.resignFirstResponder()
            timelabel.becomeFirstResponder()
            categorytable.isHidden = true
        }
        
        
        
    }
    
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

extension UITextField{
    
    func setPlaceHolderColor(){
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.white])
    }
}
