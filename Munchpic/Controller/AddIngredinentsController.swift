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
import Foundation

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
    
    @IBOutlet weak var qty1: UITextField!
    @IBOutlet weak var qty2: UITextField!
    @IBOutlet weak var qty3: UITextField!
    @IBOutlet weak var qty4: UITextField!
    @IBOutlet weak var qty5: UITextField!
    @IBOutlet weak var qty6: UITextField!
    @IBOutlet weak var qty7: UITextField!
    @IBOutlet weak var qty8: UITextField!
    @IBOutlet weak var qty9: UITextField!
    @IBOutlet weak var qty10: UITextField!
    @IBOutlet weak var qty11: UITextField!
    @IBOutlet weak var qty12: UITextField!
    @IBOutlet weak var qty13: UITextField!
    @IBOutlet weak var qty14: UITextField!
    @IBOutlet weak var qty15: UITextField!
    
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
        
        
        let ing1 = postDetails?["ingradients1"] as? String
        let result1 = ing1?.components(separatedBy: " , ")
        print((result1?.count)! as Int)
        
        if(((ing1 != "") || (ing1 != "null")) && ((result1?.count)! as Int) == 2){
            
            ingredients1.text = result1?[0]
            print(result1?[1])
            qty1.text = result1?[1]
        }else{
            ingredients1.text = postDetails?["ingradients1"] as? String
        }
        
       
        
        
        let ing2 = postDetails?["ingradients2"] as? String
        let result2 = ing2?.components(separatedBy: " , ")
        
        if(((ing2 != "") || (ing2 != "null")) && ((result2?.count)! as Int) == 2){
            ingredients2.text = result2?[0]
            qty2.text = result2?[1]
        }else{
            ingredients2.text = postDetails?["ingradients2"] as? String
        }
        
        let ing3 = postDetails?["ingradients3"] as? String
        let result3 = ing3?.components(separatedBy: " , ")
        if(((ing3 != "") || (ing3 != "null")) && ((result3?.count)! as Int) == 2){
            ingredients3.text = result3?[0]
            qty3.text = result3?[1]
        }else{
            ingredients3.text = postDetails?["ingradients3"] as? String
        }
        
        let ing4 = postDetails?["ingradients4"] as? String
        let result4 = ing4?.components(separatedBy: " , ")
        if(((ing4 != "") || (ing4 != "null")) && ((result4?.count)! as Int) == 2){
            ingredients4.text = result4?[0]
            qty4.text = result4?[1]
        }else{
            ingredients4.text = postDetails?["ingradients4"] as? String
        }
        
        let ing5 = postDetails?["ingradients5"] as? String
        let result5 = ing5?.components(separatedBy: " , ")
        if(((ing5 != "") || (ing5 != "null")) && ((result5?.count)! as Int) == 2){
            ingredients5.text = result5?[0]
            qty5.text = result5?[1]
        }else{
            ingredients5.text = postDetails?["ingradients5"] as? String
        }
        
        let ing6 = postDetails?["ingradients6"] as? String
        let result6 = ing6?.components(separatedBy: " , ")
        if(((ing6 != "") || (ing6 != "null")) && ((result6?.count)! as Int) == 2){
            ingredients6.text = result6?[0]
            qty6.text = result6?[1]
        }else{
            ingredients6.text = postDetails?["ingradients6"] as? String
        }
        
        let ing7 = postDetails?["ingradients7"] as? String
        let result7 = ing7?.components(separatedBy: " , ")
        if(((ing7 != "") || (ing7 != "null")) && ((result7?.count)! as Int) == 2){
            ingredients7.text = result7?[0]
            qty7.text = result7?[1]
        }else{
            ingredients7.text = postDetails?["ingradients7"] as? String
        }
        
        let ing8 = postDetails?["ingradients8"] as? String
        let result8 = ing8?.components(separatedBy: " , ")
        if(((ing8 != "") || (ing8 != "null")) && ((result8?.count)! as Int) == 2){
            ingredients8.text = result8?[0]
            qty8.text = result8?[1]
        }else{
            ingredients8.text = postDetails?["ingradients8"] as? String
        }
        
        let ing9 = postDetails?["ingradients9"] as? String
        let result9 = ing9?.components(separatedBy: " , ")
        if(((ing9 != "") || (ing9 != "null")) && ((result9?.count)! as Int) == 2){
            ingredients9.text = result9?[0]
            qty9.text = result9?[1]
        }else{
            ingredients9.text = postDetails?["ingradients9"] as? String
        }
        
        let ing10 = postDetails?["ingradients10"] as? String
        let result10 = ing10?.components(separatedBy: " , ")
        if(((ing10 != "") || (ing10 != "null")) && ((result10?.count)! as Int) == 2){
            ingredients10.text = result10?[0]
            qty10.text = result10?[1]
        }else{
            ingredients10.text = postDetails?["ingradients10"] as? String
        }
        
        let ing11 = postDetails?["ingradients11"] as? String
        let result11 = ing11?.components(separatedBy: " , ")
        if(((ing11 != "") || (ing11 != "null")) && ((result11?.count)! as Int) == 2){
            
            ingredients11.text = result11?[0]
            qty11.text = result1?[1]
        }else{
            ingredients11.text = postDetails?["ingradients11"] as? String
        }
        
        let ing12 = postDetails?["ingradients12"] as? String
        let result12 = ing12?.components(separatedBy: " , ")
        if(((ing12 != "") || (ing12 != "null")) && ((result12?.count)! as Int) == 2){
            
            ingredients12.text = result12?[0]
            qty12.text = result12?[1]
        }else{
            ingredients12.text = postDetails?["ingradients12"] as? String
        }
        
        
        let ing13 = postDetails?["ingradients13"] as? String
        let result13 = ing13?.components(separatedBy: " , ")
        if(((ing13 != "") || (ing13 != "null")) && ((result13?.count)! as Int) == 2){
            
            ingredients13.text = result13?[0]
            qty13.text = result13?[1]
        }else{
            ingredients13.text = postDetails?["ingradients13"] as? String
        }
        let ing14 = postDetails?["ingradients14"] as? String
        let result14 = ing14?.components(separatedBy: " , ")
        if(((ing14 != "") || (ing14 != "null")) && ((result14?.count)! as Int) == 2){
            
            ingredients14.text = result14?[0]
            qty14.text = result14?[1]
        }else{
            ingredients14.text = postDetails?["ingradients14"] as? String
        }
        
        let ing15 = postDetails?["ingradients15"] as? String
        let result15 = ing15?.components(separatedBy: " , ")
        if(((ing15 != "") || (ing15 != "null")) && ((result15?.count)! as Int) == 2){
            
            ingredients15.text = result15?[0]
            qty15.text = result15?[1]
        }else{
            ingredients15.text = postDetails?["ingradients15"] as? String
        }
        
        
        
       
       // ingredients1.text = postDetails?["ingradients1"] as? String
//        ingredients2.text = postDetails?["ingradients2"] as? String
//        ingredients3.text = postDetails?["ingradients3"] as? String
//        ingredients4.text = postDetails?["ingradients4"] as? String
//        ingredients5.text = postDetails?["ingradients5"] as? String
//        ingredients6.text = postDetails?["ingradients6"] as? String
//        ingredients7.text = postDetails?["ingradients7"] as? String
//        ingredients8.text = postDetails?["ingradients8"] as? String
//        ingredients9.text = postDetails?["ingradients9"] as? String
//        ingredients10.text = postDetails?["ingradients10"] as? String
//        ingredients11.text = postDetails?["ingradients11"] as? String
//        ingredients12.text = postDetails?["ingradients12"] as? String
//        ingredients13.text = postDetails?["ingradients13"] as? String
//        ingredients14.text = postDetails?["ingradients14"] as? String
//        ingredients15.text = postDetails?["ingradients15"] as? String
        
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
        
       
        if Reachability.isConnectedToNetwork() == true {
        
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
            
            if(self.qty1.text?.characters.count != 0){
                
               multipartFormData.append(("\(self.ingredients1.text! as String) , \(self.qty1.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients1")
            }else{
                
                multipartFormData.append((self.ingredients1.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients1")
            }

            if(self.qty2.text?.characters.count != 0){
                 multipartFormData.append(("\(self.ingredients2.text! as String) , \(self.qty2.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients2")
            }else{
                
                 multipartFormData.append((self.ingredients2.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients2")
            }
            
            if(self.qty3.text?.characters.count != 0){
                
                 multipartFormData.append(("\(self.ingredients3.text! as String) , \(self.qty3.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients3")
            }else{
                
                 multipartFormData.append((self.ingredients3.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients3")
            }
            
            if(self.qty4.text?.characters.count != 0){
                multipartFormData.append(("\(self.ingredients4.text! as String) , \(self.qty4.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients4")
            }else{
                
                multipartFormData.append((self.ingredients4.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients4")
            }
            if(self.qty5.text?.characters.count != 0){
                
                multipartFormData.append(("\(self.ingredients5.text! as String) , \(self.qty5.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients5")
            }else{
                
                multipartFormData.append((self.ingredients5.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients5")
            }
            if(self.qty6.text?.characters.count != 0){
                
                multipartFormData.append(("\(self.ingredients6.text! as String) , \(self.qty6.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients6")
            }else{
                
                multipartFormData.append((self.ingredients6.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients6")
            }
            if(self.qty7.text?.characters.count != 0){
                
                 multipartFormData.append(("\(self.ingredients7.text! as String) , \(self.qty7.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients7")
            }else{
                
                 multipartFormData.append((self.ingredients7.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients7")
            }
            if(self.qty8.text?.characters.count != 0){
                multipartFormData.append(("\(self.ingredients8.text! as String) , \(self.qty8.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients8")
            }else{
                multipartFormData.append((self.ingredients8.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients8")
            }
            if(self.qty9.text?.characters.count != 0){
                
                multipartFormData.append(("\(self.ingredients9.text! as String) , \(self.qty9.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients9")
            }else{
                multipartFormData.append((self.ingredients9.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients9")
            }
            if(self.qty10.text?.characters.count != 0){
                 multipartFormData.append(("\(self.ingredients10.text! as String) , \(self.qty10.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients10")
            }else{
                 multipartFormData.append((self.ingredients10.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients10")
            }
            if(self.qty11.text?.characters.count != 0){
                 multipartFormData.append(("\(self.ingredients11.text! as String) , \(self.qty11.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients11")
            }else{
                 multipartFormData.append((self.ingredients11.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients11")
            }
            if(self.qty12.text?.characters.count != 0){
                multipartFormData.append(("\(self.ingredients12.text! as String) , \(self.qty12.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients12")
            }else{
                multipartFormData.append((self.ingredients12.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients12")
            }
            if(self.qty13.text?.characters.count != 0){
                multipartFormData.append(("\(self.ingredients13.text! as String) , \(self.qty13.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients13")
            }else{
                multipartFormData.append((self.ingredients13.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients13")
            }
            if(self.qty14.text?.characters.count != 0){
                  multipartFormData.append(("\(self.ingredients14.text! as String) , \(self.qty14.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients14")
            }else{
                  multipartFormData.append((self.ingredients14.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients14")
            }
            if(self.qty15.text?.characters.count != 0){
                
                multipartFormData.append(("\(self.ingredients15.text! as String) , \(self.qty15.text! as String)".data(using: String.Encoding.utf8)!), withName: "ingradients15")
            }else{
                
               multipartFormData.append((self.ingredients15.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients15")
            }
           
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

        
        }else{
            
             Utility.showAlert(title: "Alert", message: "Please check your internet connection.", controller: self,completion:nil)
        }
        
        
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
