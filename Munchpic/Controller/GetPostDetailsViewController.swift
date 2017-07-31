//
//  GetPostDetailsViewController.swift
//  Munchpic
//
//  Created by ypo on 24/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import  MBProgressHUD

class GetPostDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate {
    
    @IBOutlet weak var user_image: UIImageView!
    @IBOutlet weak var user_name: UILabel!
    @IBOutlet weak var postimage: UIImageView!
    @IBOutlet weak var emojis_view: UIView!
   
    @IBOutlet weak var disc_label: UILabel!
  
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
    @IBOutlet weak var tableheightconstraint: NSLayoutConstraint!
    
    @IBOutlet weak var editbtn: UIButton!
    @IBOutlet weak var effortview: UIView!
    @IBOutlet weak var effortlevelimage: UIImageView!
    
     var isShowingDescription = true
     var emojiesviewbool = Bool()
    var commentsviewbool = Bool()
    var commentsArray = [[String:AnyObject]] ()
    var postId = Int()
    var postDetails :[String:AnyObject]?
    var ingrediantordicrstr = NSString()
    var isPostEditable = Bool()
    var ingrediantsarray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emojis_view.isHidden = true
        commentsview.isHidden = true
        effortview.isHidden = true
        editbtn.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GetPostDetailsViewController.closeview))
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        commentsview .addGestureRecognizer(tapGesture)
        
        
        post_text.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        post_text.layer.cornerRadius = 5
        post_text.layer.borderWidth = 0.5
        post_text.clipsToBounds = true
        
        ingrediantstable.isScrollEnabled = false
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ServiceLayer.getPostDetails(forPostId: postId) { (responseArray , status, msg) in
            
            DispatchQueue.main.async(execute: {
                MBProgressHUD.hide(for: self.view, animated: true)
            })
            
            if status == true && (responseArray?.count)! > 0 {
                self.postDetails = responseArray?[0]
                
                DispatchQueue.main.async(execute: {
                    self.UpdateUI()
                    self.ingrediantstable.estimatedRowHeight = 80;
                    self.ingrediantstable.rowHeight = UITableViewAutomaticDimension;
                    self.ingrediantordicrstr = "Ingrediantsneeded"
                    self.loadingrediantsTabledata()
                    self.ingrediantstable.reloadData()


                })
            }
            
        }
        
        if(isPostEditable == true){
            
            editbtn.isHidden = false
        }

    }
    
    func closeview(){
        
        commentsviewbool = false
        commentsview.isHidden = true
        
    }
    
    func closeeffortview(){
        
        effortview.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        
        mscrollview.isScrollEnabled = true
        mscrollview.contentSize = CGSize(width: self.view.frame.size.width, height:mscrollview.contentSize.height)
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
        
        effortview.isHidden = false
        
        let effertlevellabl = postDetails?["difficulty"] as? String
        
        if (effertlevellabl == "1"){
            effortlevelimage.image = UIImage(named:"prepare")
        }else if(effertlevellabl == "2"){
            effortlevelimage.image = UIImage(named:"prepare")
        }else if(effertlevellabl == "3"){
            effortlevelimage.image = UIImage(named:"prepare")
        }else if(effertlevellabl == "4"){
            effortlevelimage.image = UIImage(named:"prepare")
        }else{
            effortlevelimage.image = UIImage(named:"prepare")
        }
        
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(GetPostDetailsViewController.closeeffortview))
        self.view.addGestureRecognizer(tapGesture1)
        tapGesture1.cancelsTouchesInView = false
        effortview .addGestureRecognizer(tapGesture1)
        
       
        
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
        
        ingrediantordicrstr = "Ingrediantsneeded"
        self.loadingrediantsTabledata()
        self.ingrediantstable.reloadData()
        
    }
    
    @IBAction func discription_action(_ sender: Any) {
        
        ingrediantordicrstr = "Discription"
        self.loadingrediantsTabledata()
        self.ingrediantstable.reloadData()
       
    }
    
    @IBAction func editpost_Action(_ sender: Any) {
        
        
        
    }
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if(tableView == commentsTable){
            return self.commentsArray.count
        }
        if(tableView == ingrediantstable){
            
           return self.ingrediantsarray.count
            
        }

        return 0
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
        
        
        var cell:UITableViewCell? = ingrediantstable.dequeueReusableCell(withIdentifier: "cell")
        if(cell == nil)
        {
            cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: "cell")
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
        }
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
        cell?.textLabel?.sizeToFit()
        cell?.textLabel?.text = "\(indexPath.row+1)." + (ingrediantsarray[indexPath.row] as? String)!
        cell?.textLabel?.numberOfLines = 0
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.black.cgColor
        tableheightconstraint.constant = ingrediantstable.contentSize.height
        ingrediantstable.frame.size.height = ingrediantstable.contentSize.height
        mscrollview.contentSize = CGSize(width: self.view.frame.size.width, height:mscrollview.frame.size.width+ingrediantstable.contentSize.height+200)
        return cell!;

       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

    
    //MARK: - Update UI
    func UpdateUI() {
        self.user_name.text = postDetails?["userName"] as? String
        self.itemname.text = postDetails?["dishName"] as? String
        self.effoert.text = postDetails?["difficulty"] as? String
        self.smiles.text = postDetails?["loves"] as? String
        self.timetaken.text = postDetails?["effort"] as? String
        self.calories.text = postDetails?["calories"] as? String
        comments.text = postDetails?["comments"] as? String
    
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

    func loadingrediantsTabledata(){
        
        if(ingrediantordicrstr == "Ingrediantsneeded"){
            ingrediantsarray.removeAllObjects()
        var arraylength = 0
        for i in 1...16 {
            
            let idno = "ingradients\(i)"
            let ingrediantstr = postDetails?["\(idno)"] as? String
            if ingrediantstr == "" || ingrediantstr == nil || ingrediantstr == "null" {
                
            }else{
                
            ingrediantsarray.insert(ingrediantstr , at: arraylength)
                arraylength = arraylength + 1
        
            }
        }

        }else if(ingrediantordicrstr == "Discription"){
            
            ingrediantsarray.removeAllObjects()
            var arraylength = 0
            
            for i in 1...16 {
                
                let dno = "description\(i)"
                let discstr = postDetails?["\(dno)"] as? String
                if discstr == "null" || discstr == nil || discstr == ""{
                    
                }else{
                    
                    ingrediantsarray.insert(discstr , at: arraylength)
                    arraylength = arraylength + 1
                    
                }
            }

            
        }
    }
    

    func textViewDidBeginEditing(_ textView: UITextView) {
        
        postbtn.setImage(UIImage(named :"postarrow"), for: UIControlState.normal)
        
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
