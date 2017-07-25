//
//  GetPostDetailsViewController.swift
//  Munchpic
//
//  Created by ypo on 24/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import  MBProgressHUD

class GetPostDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var user_image: UIImageView!
    @IBOutlet weak var user_name: UILabel!
    @IBOutlet weak var postimage: UIImageView!
    @IBOutlet weak var emojis_view: UIView!
   
    @IBOutlet weak var disc_label: UILabel!
    @IBOutlet weak var disc_view: UIView!
    @IBOutlet weak var ingrediantstable: UITableView!
    @IBOutlet weak var selected_label: UILabel!
    @IBOutlet weak var commentsview: UIView!
 
    @IBOutlet weak var commentsTable: UITableView!
    @IBOutlet weak var post_text: UITextView!
    @IBOutlet weak var postbtn: UIButton!
    @IBOutlet weak var mscrollview: UIScrollView!
    
    @IBOutlet weak var smiles: UILabel!
    @IBOutlet weak var timetaken: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var effoert: UILabel!
    @IBOutlet weak var itemname: UILabel!
    
     var isShowingDescription = true
     var emojiesviewbool = Bool()
    var commentsviewbool = Bool()
    var commentsArray = [[String:AnyObject]] ()
    var postId = Int()
    var postDetails :[String:AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emojis_view.isHidden = true
        commentsview.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GetPostDetailsViewController.closeview))
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        commentsview .addGestureRecognizer(tapGesture)
        
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ServiceLayer.getPostDetails(forPostId: postId) { (responseArray , status, msg) in
            
            DispatchQueue.main.async(execute: {
                MBProgressHUD.hide(for: self.view, animated: true)
            })
            
            if status == true && (responseArray?.count)! > 0 {
                self.postDetails = responseArray?[0]
                DispatchQueue.main.async(execute: {
//                    self.ingrediantstable.reloadData()
                   self.UpdateUI()
                })
            }
            
        }

        
    }
    
    func closeview(){
        
        commentsviewbool = false
        commentsview.isHidden = true
        
    }
    
    override func viewDidLayoutSubviews() {
        mscrollview.isScrollEnabled = true
        mscrollview.contentSize = CGSize(width: self.view.frame.size.width, height:1024)
    }
    
    @IBAction func smiles_Action(_ sender: Any) {
        
        if(emojiesviewbool == false){
            
            emojis_view.isHidden = false
            emojiesviewbool = true
            
        }else{
            
            emojis_view.isHidden = true
            emojiesviewbool = false
        }
        
        
    }
    @IBAction func postbtn_action(_ sender: Any) {
        
        let commenttxt = self.post_text.text as String
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let param = "userId=\(userId)" +
                "&postId=\(postId)" +
            "&comments=\(commenttxt)"
            
            ServiceLayer.insertComments(parameter: param) { (response, status, msg) in
                print(msg)
                if status && msg == "Commented" {
                    DispatchQueue.main.async(execute: {
                        self.commentsview.isHidden = false
                        Utility.showAlert(title: "Muchpic", message:"Your comment posted successfully.", controller: self,completion:nil)
                        
                    })
                    
                }
            }
        }

        self.updatedcommentslist()
//        commentsviewbool = false
//        commentsview.isHidden = true
        
    }
    
    func updatedcommentslist(){
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ServiceLayer.GetComments(forPostId:postId) { (response, status, mess) in
            
            DispatchQueue.main.async(execute: {
                
                MBProgressHUD.hide(for: self.view, animated: true)
            })
            
            if let resCommentsArray = response {
                self.commentsArray = resCommentsArray
                
            }
            
            DispatchQueue.main.async(execute: {
                self.commentsview.isHidden = false
                if self.commentsArray.count == 0 {
                   
                                   }
                else {
                    
                    
                }
                
                self.commentsTable.reloadData()
            })

        
    }
        
    }
    
    @IBAction func commentes_Action(_ sender: Any) {
        
        if(commentsviewbool == false){
            commentsviewbool = true
            commentsview.isHidden = false
            self.updatedcommentslist()
        }else{
            commentsviewbool = false
            commentsview.isHidden = true
        }
        
        
        
    }
    @IBAction func preparetation_type(_ sender: Any) {
        
    }
    
    //Emojise Button actions
   
    @IBAction func emoji1_action(_ sender: Any) {
        
    }
    @IBAction func emoji2_Action(_ sender: Any) {
        
    }
    @IBAction func emoji3_Action(_ sender: Any) {
        
    }
    @IBAction func emoji4_action(_ sender: Any) {
        
    }
    @IBAction func emoji5_action(_ sender: Any) {
        
    }
    @IBAction func emoji6_action(_ sender: Any) {
        
    }
    
    @IBAction func Ingrediants_action(_ sender: Any) {
        
        selected_label.text = "Ingrediants needed"
        disc_view.isHidden =  true
        ingrediantstable.isHidden = false
        
    }
    @IBAction func discription_action(_ sender: Any) {
        
        selected_label.text = "Discription"
         ingrediantstable.isHidden = true
        disc_view.isHidden = false
       
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if(tableView == commentsTable){
            return self.commentsArray.count
        }
        if isShowingDescription == false {
         return getRowCountForIngredients(coloumnKey:"ingradients")
        }
        return getRowCountForIngredients(coloumnKey:"description")
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(tableView == commentsTable){
        
        let cell : CommentCell = self.commentsTable.dequeueReusableCell(withIdentifier: "commnetsCell") as! CommentCell
        
        let commentObj = commentsArray[indexPath.row]
        cell.commentLabel.text = commentObj["comments"] as? String
        cell.userName.text = commentObj["userName"] as? String
        
        if let userId = commentsArray[indexPath.row]["userId"] {
            let imgrl = "http://ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(String(describing: userId))/user.jpg"
            URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let data =  data1 {
                        cell.userPic.image = UIImage(data: data)
                    }
                })
                }.resume()
            
        }
        
        
        return cell
        
        }
        
        
        let cell = ingrediantstable.dequeueReusableCell(withIdentifier: "cell")
        let view =  cell?.viewWithTag(3)!
        view?.layer.borderColor = UIColor.gray.cgColor
        view?.layer.borderWidth = 1
        let label =  view?.viewWithTag(10) as! UILabel
        
        if let detail = postDetails {
            if isShowingDescription {
                let key = "description\(indexPath.row+1)"
                label.text = "step\(indexPath.row+1):" + ( detail[key] as? String)!
                
            }
            else {
                let key = "ingradients\(indexPath.row+1)"
                label.text = "\(indexPath.row+1)." + ( detail[key] as? String)!
                
            }
        }
        return cell!

       
       
    }

    
    func getRowCountForIngredients(coloumnKey:String)->Int {
        
        var lenghth = 0
        for i in 1...16 {
            let key = "\(coloumnKey)\(i)"
            if let value =  postDetails?[key]  as? String{
                if value == "" {
                    continue
                }
                lenghth = i
            }
        }
        
        return lenghth
    }
    
    //MARK: - Update UI
    func UpdateUI() {
        self.user_name.text = postDetails?["userName"] as? String
        self.itemname.text = postDetails?["dishName"] as? String
        
        self.smiles.text = postDetails?["loves"] as? String
        self.timetaken.text = postDetails?["effort"] as? String
        self.calories.text = postDetails?["calories"] as? String
        comments.text = postDetails?["collections"] as? String
        // noOfCommentsLabel.text = postDetails?["comments"] as? String
        if let name = postDetails?["dishName"] {
            selected_label.text = "How to prepare \(name))"
            
        }
        
        
        
        let  userId  = Int(postDetails?["userId"] as! String)!
        
        let imgrl = "http://ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(userId)/user.jpg"
        
        URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                if let data =  data1 {
                    self.user_image.image = UIImage(data: data)
                }
            })
            }.resume()
        
        
        URLSession.shared.dataTask(with: URL(string:postDetails?["ImagePath1"] as! String)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                if let imageData = data1 {
                    self.postimage.image = UIImage(data: imageData)
                }
            })
            }.resume()
        
        
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
