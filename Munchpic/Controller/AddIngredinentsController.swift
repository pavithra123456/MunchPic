//
//  AddIngredinentsController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 17/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import Alamofire
class AddIngredinentsController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var ingredients1: UITextField!
    @IBOutlet weak var ingredients2: UITextField!
    
    @IBOutlet weak var ingredients3: UITextField!
    
    @IBOutlet weak var ingredients4: UITextField!
    
    @IBOutlet weak var ingredients5: UITextField!
    
    @IBOutlet weak var ingredients6: UITextField!
    
    @IBOutlet weak var ingredients7: UITextField!
    
    @IBOutlet weak var ingredients8: UITextField!
    
    @IBOutlet weak var ingredients9: UITextField!
    
    @IBOutlet weak var ingredients110: UITextField!
    
    @IBOutlet weak var ingredients11: UITextField!
    
    @IBOutlet weak var ingredients12: UITextField!
    
    @IBOutlet weak var ingredients13: UITextField!
    
    @IBOutlet weak var ingredients14: UITextField!
    
    @IBOutlet weak var ingredients15: UITextField!
    
    var postModel : PostModel?
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollview.contentSize = CGSize(width: scrollview.contentSize.width, height: 2200)
    }
    override func viewDidLayoutSubviews() {
        scrollview.isScrollEnabled = true
        scrollview.contentSize = CGSize(width: scrollview.contentSize.width, height: scrollview.contentSize.height+350)
    }

    @IBAction func uploadBtnAction(_ sender: Any) {
    
        var url = URLRequest(url: URL(string: Constants.kBaseUrl + Constants.kInsertPost)!)
        url.httpMethod = "POST"
        Alamofire.upload(multipartFormData: { (multipartFormData) in
        
            
            multipartFormData.append(UIImageJPEGRepresentation((self.postModel?.post1!)!, 1)!, withName: "post1", fileName: "_post1.jpg", mimeType: "image/jpeg")
            multipartFormData.append(UIImageJPEGRepresentation((self.postModel?.post2!)!, 1)!, withName: "post2", fileName: "_post2.jpg", mimeType: "image/jpeg")
            multipartFormData.append(UIImageJPEGRepresentation((self.postModel?.post3!)!, 1)!, withName: "post3", fileName: "_post3.jpg", mimeType: "image/jpeg")

            multipartFormData.append("\(38)".data(using: String.Encoding.utf8)!, withName: "userId")
            multipartFormData.append((self.postModel?.dishName.data(using: String.Encoding.utf8)!)!, withName: "dishName")
            
            multipartFormData.append((self.postModel?.description1.data(using: String.Encoding.utf8)!)!, withName: "description1")
            multipartFormData.append((self.postModel?.description2.data(using: String.Encoding.utf8)!)!, withName: "description2")
            multipartFormData.append((self.postModel?.description3.data(using: String.Encoding.utf8)!)!, withName: "description3")
            multipartFormData.append((self.postModel?.description4.data(using: String.Encoding.utf8)!)!, withName: "description4")
            multipartFormData.append((self.postModel?.description5.data(using: String.Encoding.utf8)!)!, withName: "description5")

            multipartFormData.append((self.ingredients1.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients1")
            multipartFormData.append((self.ingredients2.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients2")
            multipartFormData.append((self.ingredients3.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients3")
            multipartFormData.append((self.ingredients4.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients4")
            multipartFormData.append((self.ingredients5.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients5")
            multipartFormData.append((self.ingredients6.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients6")
            multipartFormData.append((self.ingredients7.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients7")
            multipartFormData.append((self.ingredients7.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients8")
            multipartFormData.append((self.ingredients7.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients9")
            multipartFormData.append((self.ingredients7.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients10")
            multipartFormData.append((self.ingredients7.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients11")
            multipartFormData.append((self.ingredients7.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients12")
            multipartFormData.append((self.ingredients7.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients13")
            multipartFormData.append((self.ingredients7.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients14")

            multipartFormData.append((self.ingredients7.text?.data(using: String.Encoding.utf8)!)!, withName: "ingradients15")



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
                            self.navigationController?.popViewController(animated: true)
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
