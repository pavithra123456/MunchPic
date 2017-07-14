//
//  NewPostViewController.swift
//  NewpostView
//
//  Created by ypomacmini on 13/07/17.
//  Copyright © 2017 YourPracticeOnline. All rights reserved.
//

import UIKit
import MobileCoreServices

class NewPostViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIScrollViewDelegate {

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
    var imagesarray = NSMutableArray()
    var mPosition:Int = Int()
    var myint = Int()
    var index = 0
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    @IBOutlet var mscrollview: UIScrollView!
    
    @IBOutlet var selectCategory: UITextField!
    @IBOutlet var selectcuisine: UITextField!
    @IBOutlet var step1: UITextField!
    @IBOutlet var step2: UITextField!
    @IBOutlet var setp3: UITextField!
    @IBOutlet var step4: UITextField!
    @IBOutlet var timelabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        self.swipeGestureLeft.addTarget(self, action:#selector(NewPostViewController.handleSwipeLeft(gesture:)))
        self.swipeGestureRight.addTarget(self, action:#selector(NewPostViewController.handleSwipeRight(gesture:)))
        mscrollview.addGestureRecognizer(self.swipeGestureLeft)
        mscrollview.addGestureRecognizer(self.swipeGestureRight)
        
       // imagesarray = ["Noimage.png","Noimage.png","Noimage.png"]
        imagesarray = ["Noimage.png","Noimage.png","Noimage.png"]

    }
    
    override func viewDidLayoutSubviews() {
        mscrollview.isScrollEnabled = true
        mscrollview.contentSize = CGSize(width: mscrollview.contentSize.width, height: mscrollview.contentSize.height)
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
            
            pageimage.image = image
          //  imagesarray.insert(image, at: indexval)
             imagesarray.replaceObject(at: indexval, with: image)
            print("imageinsert at \(imagesarray) at indexof \(indexval)")
            pagecontroller.currentPage = indexval
            
        }
        
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
        
       // _ = SweetAlert().showAlert("Alert!", subTitle: "Veryeasy to prepare.", style: AlertStyle.warning)
    }
    @IBAction func easybtn_Action(_ sender: Any) {
        
        veryeasyBtn.backgroundColor = UIColor(hex: "276C22")
        easybtn.backgroundColor = UIColor(hex: "2A9024")
        mediumBtn.backgroundColor = UIColor(hex: "B8B8B8")
        difficultBtn.backgroundColor = UIColor(hex: "B8B8B8")
        verudifficultBtn.backgroundColor = UIColor(hex: "B8B8B8")
      //  _ = SweetAlert().showAlert("Alert!", subTitle: "Easy to prepare.", style: AlertStyle.warning)
        
    }
    @IBAction func mediumbtn_Action(_ sender: Any) {
        
        veryeasyBtn.backgroundColor = UIColor(hex: "276C22")
        easybtn.backgroundColor = UIColor(hex: "2A9024")
        mediumBtn.backgroundColor = UIColor(hex: "DE763E")
        difficultBtn.backgroundColor = UIColor(hex: "B8B8B8")
        verudifficultBtn.backgroundColor = UIColor(hex: "B8B8B8")
       // _ = SweetAlert().showAlert("Alert!", subTitle: "Medium to prepare.", style: AlertStyle.warning)
        
    }
    @IBAction func difficultbtn_Action(_ sender: Any) {
        
        veryeasyBtn.backgroundColor = UIColor(hex: "276C22")
        easybtn.backgroundColor = UIColor(hex: "2A9024")
        mediumBtn.backgroundColor = UIColor(hex: "DE763E")
        difficultBtn.backgroundColor = UIColor(hex: "CF6049")
        verudifficultBtn.backgroundColor = UIColor(hex: "B8B8B8")
       // _ = SweetAlert().showAlert("Alert!", subTitle: "Difficult to prepare.", style: AlertStyle.warning)
        
    }
    @IBAction func verydifficult_Action(_ sender: Any) {
        
        veryeasyBtn.backgroundColor = UIColor(hex: "276C22")
        easybtn.backgroundColor = UIColor(hex: "2A9024")
        mediumBtn.backgroundColor = UIColor(hex: "DE763E")
        difficultBtn.backgroundColor = UIColor(hex: "CF6049")
        verudifficultBtn.backgroundColor = UIColor(hex: "CF4B49")
      //  _ = SweetAlert().showAlert("Alert!", subTitle: "Verydifficuly to prepare.", style: AlertStyle.warning)
      
    }
    
    
    @IBAction func Back_Action(_ sender: Any) {
     
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func ingrediantsBtn_Avtiom(_ sender: Any) {
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
