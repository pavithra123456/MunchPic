//
//  AddIngredinentsController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 17/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class AddIngredinentsController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate{

    @IBOutlet weak var ingredients1: UITextField!
    @IBOutlet weak var ingredients2: UITextField!
    @IBOutlet weak var ingredients3: UITextField!
    @IBOutlet weak var ingredients4: UITextField!
    @IBOutlet weak var ingredients5: UITextField!
    @IBOutlet weak var ingredients6: UITextField!
    @IBOutlet weak var ingredients7: UITextField!
    @IBOutlet weak var ingredients8: UITextField!
    @IBOutlet weak var ingredients9: UITextField!
    @IBOutlet weak var ingredients10: UITextField!
    @IBOutlet weak var ingredients11: UITextField!
    @IBOutlet weak var ingredients12: UITextField!
    @IBOutlet weak var ingredients13: UITextField!
    @IBOutlet weak var ingredients14: UITextField!
    @IBOutlet weak var ingredients15: UITextField!
    
    @IBOutlet weak var sv6: UIView!
    
    @IBOutlet weak var sv14: UIView!
    @IBOutlet weak var sv13: UIView!
    @IBOutlet weak var sv12: UIView!
    @IBOutlet weak var sv11: UIView!
    @IBOutlet weak var sv10: UIView!
    @IBOutlet weak var sv9: UIView!
    @IBOutlet weak var sv8: UIView!
    @IBOutlet weak var sv7: UIView!
    @IBOutlet weak var sv15: UIView!
    
    @IBOutlet weak var heightconstraint: NSLayoutConstraint!
    var downint : Int = 6
    var hconstant :Int = 10
    
    @IBOutlet weak var addview: UIView!
    var postModel : PostModel?
    var postDetails :[String:AnyObject]?
    var postIdis = Int()
    


    
    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollview.contentSize = CGSize(width: scrollview.contentSize.width, height: scrollview.contentSize.height)
//        mainstackview.contentMode = UIViewContentMode(rawValue: Int(scrollview.contentSize.height))!
        
        ingredients1.delegate = self
        ingredients2.delegate = self
        ingredients3.delegate = self
        ingredients4.delegate = self
        ingredients5.delegate = self
        ingredients6.delegate = self
        ingredients7.delegate = self
        ingredients8.delegate = self
         ingredients9.delegate = self
         ingredients10.delegate = self
         ingredients11.delegate = self
         ingredients12.delegate = self
         ingredients13.delegate = self
         ingredients14.delegate = self
         ingredients15.delegate = self

        
        if(UserDefaults.standard.bool(forKey: "editvisible") == true){
            
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

    }
    
    override func viewDidLayoutSubviews() {
        scrollview.isScrollEnabled = true
       
        if(downint > 6 && downint < 10){
            
            scrollview.contentSize = CGSize(width: scrollview.contentSize.width, height: 900)
            
        }else if(downint > 10 ){
            
             scrollview.contentSize = CGSize(width: scrollview.contentSize.width, height: 1300)
        }else{
            
             scrollview.contentSize = CGSize(width: scrollview.contentSize.width, height: 500)
        }
        
    }
    
    func UpdateUI(){
        
       
        ingredients1.text = postDetails?["ingradients1"] as? String
        ingredients2.text = postDetails?["ingradients2"] as? String
        ingredients3.text = postDetails?["ingradients3"] as? String
        ingredients4.text = postDetails?["ingradients4"] as? String
        ingredients5.text = postDetails?["ingradients5"] as? String
        ingredients6.text = postDetails?["ingradients6"] as? String
        ingredients7.text = postDetails?["ingradients7"] as? String
        ingredients8.text = postDetails?["ingradients8"] as? String
        ingredients9.text = postDetails?["ingradients9"] as? String
        ingredients10.text = postDetails?["ingradients10"] as? String
        ingredients11.text = postDetails?["ingradients11"] as? String
        ingredients12.text = postDetails?["ingradients12"] as? String
        ingredients13.text = postDetails?["ingradients13"] as? String
        ingredients14.text = postDetails?["ingradients14"] as? String
        ingredients15.text = postDetails?["ingradients15"] as? String
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func add_Action(_ sender: Any) {
        
        
        
        if(downint>15){
            
            Utility.showAlert(title: "Alert", message: "Maximum 15 Ingredients ", controller: self,completion:nil)
            
        }else{
            
            hconstant = hconstant + 60
            heightconstraint.constant = CGFloat(hconstant)
            
            if(downint == 6){
                sv6.isHidden = false
                scrollview.contentSize = CGSize(width: scrollview.contentSize.width, height: 900)
            }else if(downint == 7){
                sv7.isHidden = false
                
            }else if(downint == 8){
                sv8.isHidden = false
                
            }else if(downint == 9){
                sv9.isHidden = false
                
            }else if(downint == 10){
                sv10.isHidden = false
                scrollview.contentSize = CGSize(width: scrollview.contentSize.width, height: 1300)
                
            }else if(downint == 11){
                sv11.isHidden = false
                
            }else if(downint == 12){
                sv12.isHidden = false
                
            }else if(downint == 13){
                sv13.isHidden = false
                
            }else if(downint == 14){
                sv14.isHidden = false
                
            }else if(downint == 15){
                sv15.isHidden = false
                
            }else{
                
            }
            downint = downint+1
        }
        
        
        
        
    }
    
    

    @IBAction func uploadBtnAction(_ sender: Any) {
        let textfeildscount = 0
        
//        for i in 1...15 {
//            
//            let addedtext = "ingredients\(i)".text? as String
//            
//            if(addedtext.text? == ""){
//                
//            }else{
//                textfeildscount = textfeildscount + 1
//            }
//            
//        }
        
        let mystr : String
        
        if(UserDefaults.standard.bool(forKey: "editvisible") == true){
            
             mystr = (Constants.kBaseUrl + Constants.KUpdateUserPost)
            
            
        }else{
            
            mystr  = (Constants.kBaseUrl + Constants.kInsertPost)
        }

        var url = URLRequest(url: URL(string: mystr)!)

    
        
        url.httpMethod = "POST"
        Alamofire.upload(multipartFormData: { (multipartFormData) in
        
            
            multipartFormData.append(UIImageJPEGRepresentation((self.postModel?.post1!)!, 1)!, withName: "post1", fileName: "_post1.jpg", mimeType: "image/jpeg")
            multipartFormData.append(UIImageJPEGRepresentation((self.postModel?.post2!)!, 1)!, withName: "post2", fileName: "_post2.jpg", mimeType: "image/jpeg")
            multipartFormData.append(UIImageJPEGRepresentation((self.postModel?.post3!)!, 1)!, withName: "post3", fileName: "_post3.jpg", mimeType: "image/jpeg")

            if let userId =  UserDefaults.standard.value(forKey: "userId") {
                multipartFormData.append("\(userId)".data(using: String.Encoding.utf8)!, withName: "userId")
            }

            multipartFormData.append((self.postModel?.dishName.data(using: String.Encoding.utf8)!)!, withName: "dishName")
            
//            for i in 1...(self.postModel?.descriptionArray.count)!{
//                let ingredientsKay = "ingradients\(i)"
//
//                multipartFormData.append((self.postModel?.descriptionArray[i].data(using: String.Encoding.utf8)!)!, withName: ingredientsKay)
//
//            }
            
            for i in 1...(self.postModel?.descriptionArray.count)!{
                
                let ingredientsKay = "description\(i)"
                let j = i - 1
                
                multipartFormData.append((self.postModel?.descriptionArray[j].data(using: String.Encoding.utf8)!)!, withName: ingredientsKay)
                
            }

            multipartFormData.append((self.ingredients1.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients1")
            multipartFormData.append((self.ingredients2.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients2")
            multipartFormData.append((self.ingredients3.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients3")
            multipartFormData.append((self.ingredients4.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients4")
            multipartFormData.append((self.ingredients5.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients5")
            multipartFormData.append((self.ingredients6.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients6")
            multipartFormData.append((self.ingredients7.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients7")
            multipartFormData.append((self.ingredients8.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients8")
            multipartFormData.append((self.ingredients9.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients9")
            multipartFormData.append((self.ingredients10.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients10")
            multipartFormData.append((self.ingredients11.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients11")
            multipartFormData.append((self.ingredients12.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients12")
            multipartFormData.append((self.ingredients13.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients13")
            multipartFormData.append((self.ingredients14.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients14")
            multipartFormData.append((self.ingredients15.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients15")
           
            if(UserDefaults.standard.bool(forKey: "editvisible") == true){
                
            let xString : String =  "\(self.postIdis)"
            multipartFormData.append((xString.data(using: String.Encoding.utf8)!), withName: "postId")
                
            }
            


            multipartFormData.append((self.postModel?.cuisine.data(using: String.Encoding.utf8)!)!, withName: "cuisine")
            multipartFormData.append((self.postModel?.category.data(using: String.Encoding.utf8)!)!, withName: "category")
            multipartFormData.append((self.postModel?.subCategory.data(using: String.Encoding.utf8)!)!, withName: "subCategory")
            multipartFormData.append((self.postModel?.difficulty.data(using: String.Encoding.utf8)!)!, withName: "difficulty")
            multipartFormData.append((self.postModel?.efforts.data(using: String.Encoding.utf8)!)!, withName: "duration")

                    }, with: url, encodingCompletion: { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseString(completionHandler: { (responseString) in
                    print(responseString.description)
                    DispatchQueue.main.async {
                        
                        Utility.showAlert(title: "MunchPic", message: responseString.description as String, controller: self,completion:{(action) in
//                            if(UserDefaults.standard.bool(forKey: "editvisible") == true){
//                                
//                            }else{
                            
                                self.navigationController?.popViewController(animated: true)
//                            }
                            
                        })
                    }
                })
            case .failure(let encodingError):
                print(encodingError)
            }
            
        });

        
    }
    
    
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
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
