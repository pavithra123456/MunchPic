//
//  DetailViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import MBProgressHUD
let offset_HeaderStop:CGFloat = 40.0 // At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = 95.0 // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 35.0 // The distance between the bottom of the Header and the top of the White Label

class DetailViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextViewDelegate {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var mainImageview: UIImageView!
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPic: UIImageView!
    
    @IBOutlet weak var commentsViewChatImage: UIImageView!
    
    @IBOutlet weak var commentsview: UIView!
    @IBOutlet weak var collectionListView: UIView!
    
    var postId = 0
    var postDetails :PostModel?
    var isShowingDescription = true
    
    
    var tapguesture : UITapGestureRecognizer?
    var commentsArray = [[String:AnyObject]] ()

    @IBOutlet weak var commentsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var commentsTableView: UITableView!
    
    @IBOutlet weak var commentsContainerHeight: NSLayoutConstraint!
    
    @IBOutlet weak var smiliesView: BorderedView!
    
    @IBOutlet weak var commentsTextviewContainer: UIView!
    
    var radioButtonArray = [RadioButton]()
    
    @IBOutlet weak var radioBtn1: RadioButton!
    @IBOutlet weak var radioBtn2: RadioButton!
    @IBOutlet weak var radioBtn3: RadioButton!
    @IBOutlet weak var radioBtn4: RadioButton!
    @IBOutlet weak var radioBtn5: RadioButton!
    @IBOutlet weak var radioBtn6: RadioButton!
    
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var noOfCommentsLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var noOfSmilesLabel: UILabel!
    @IBOutlet weak var timeToCookLabel: UILabel!
    
    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var DifficultyView: UIView!

    @IBOutlet weak var difficultyImage: UIImageView!
    //MAR: - Edit btn
    @IBOutlet weak var editPostsBtn: UIButton!
    var isPostEditable = false
    var isDetaiLForLovedPost = false

    
    //MARK: - BottomView 
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var addcommentView: BorderedView!
    
    @IBOutlet weak var commentsTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.estimatedRowHeight = 15
        tableView.isUserInteractionEnabled = true
        tableView.isScrollEnabled = true

        
        
        commentsTableView.dataSource = self
    
        addGuestures()
        getcooments()
        addBorderToCommentsView()
        //navigationController?.setNavigationBarHidden(true, animated: true)

        radioButtonArray = [radioBtn1,radioBtn2,radioBtn3,radioBtn4,radioBtn5,radioBtn6]
        
          self.editPostsBtn.isHidden = true
               self.navigationController?.navigationBar.isHidden = true
        if isPostEditable  || isDetaiLForLovedPost{
            stackview.isHidden = true
            addcommentView.isHidden = true
        }
      
        if isPostEditable{
            self.editPostsBtn.isHidden = false
        }
        
        if postDetails == nil {
            getPostDetails()
            return
        }
        
                if let img = postDetails?.difficulty {
            let imageName = "Easy\(img)"
            difficultyImage.image = UIImage(named: imageName)
        }
        
        self.UpdateUI()
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        // Do any additional setup after loading the view.
    }
    
    func getPostDetails () {
        ServiceLayer.getPostDetails(forPostId: postId) { (responseArray , status, msg) in
            
            DispatchQueue.main.async(execute: {
                MBProgressHUD.hide(for: self.view, animated: true)
            })
            
            if status == true && (responseArray?.count)! > 0 {
                self.postDetails = PostModel.getmodel(postobject: (responseArray?[0])!)
                
                DispatchQueue.main.async(execute: {
                    self.UpdateUI()
//                    self.ingrediantstable.estimatedRowHeight = 80;
//                    self.ingrediantstable.rowHeight = UITableViewAutomaticDimension;
//                    self.ingrediantordicrstr = "Ingrediantsneeded"
//                    self.loadingrediantsTabledata()
                   self.tableView.reloadData()
//                    
                    
                })
            }
            
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func addBorderToCommentsView() {
//        commentsTextviewContainer.layer.cornerRadius = 8.0
//        commentsTextviewContainer.layer.borderWidth = 1
//        
//        commentsTextviewContainer.layer.masksToBounds = true;
//        commentsTextviewContainer.layer.borderColor = UIColor.red.cgColor
    }
    
    func getcooments() {
        ServiceLayer.GetComments(forPostId:postId) { (response, status, mess) in
            
            if let resCommentsArray = response {
                self.commentsArray = resCommentsArray
            }
            
            DispatchQueue.main.async(execute: {
                //self.commentsview.isHidden = false
//                if self.commentsArray.count == 0 {
//                    self.commentsTableViewHeight.constant = 0
//                    self.commentsContainerHeight.constant = 90
//                    self.commentsview.layoutIfNeeded()
//                }
//                else {
//                    self.commentsTableViewHeight.constant = 168
//                    self.commentsContainerHeight.constant = 252
//                    self.commentsview.layoutIfNeeded()
//                }
                self.commentsTableView.reloadData()
                self.commentsTableView.tableFooterView = UIView()
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        scrollview.contentSize = CGSize(width: self.view.frame.width, height: (addcommentView.frame.origin.y + addcommentView.frame.size.height + 30))
    }
    
    
    func addGuestures() {
        tapguesture = UITapGestureRecognizer.init(target: self, action: #selector(hidePopUps))
        tapguesture?.isEnabled = false
        self.view.addGestureRecognizer(tapguesture!)
    }
    
    func hidePopUps() {
        self.commentsview.isHidden = true
        self.collectionListView.isHidden = true
        self.tapguesture?.isEnabled = false
        self.DifficultyView.isHidden = true
        
    }

    @IBAction func addLoves(_ sender: UIButton) {
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let param = "userId=\(userId)" +
                "&postId=\(postId)" +
            "&loveId=\(sender.tag)"
            
            ServiceLayer.insertLoves(parameter: param) { (response, status, msg) in
                print(msg)
                if status && (msg == "Loved" || msg == "Expression updated") {
                    DispatchQueue.main.async(execute: {
                        Utility.showAlert(title: "Muchpic", message:"Loved", controller: self,completion:nil)
                        self.smiliesView .isHidden = true
                    })
                    
                }
            }
        }
    }
    
    @IBAction func showSmiles(_ sender: Any) {
        smiliesView.isHidden = !smiliesView.isHidden
    }
    
    //MARK: -  Radio Button Actions
    
    @IBAction func radioBtnAction(_ sender: UIButton) {
        for btn in  self.radioButtonArray {
            btn.isSelected = false
        }
        
        if sender.isSelected {
            sender.isSelected = false
        }
        else {
            sender.isSelected = true
        }
        
    }

    @IBAction func AddCollection(_ sender: Any) {
        var categoryName = ""

        for btn in  self.radioButtonArray {
            if btn.isSelected {
                categoryName = (btn.categoryLabel?.text)!
            }
        }
        
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let param = "userId=\(userId)" +
                "&postId=\(postId)" +
            "&toCategory=\(categoryName)"
            
            ServiceLayer.insertCollections(parameter: param) { (response, status, msg) in
                print(msg)
                if status == false && (msg == "Added to your collections list"  || msg == "Updated your collections list!"){
                    DispatchQueue.main.async(execute: {
                        self.collectionListView.isHidden = true
                        Utility.showAlert(title: "Muchpic", message:msg, controller: self,completion:nil)
                    })
                }
            }
        }
    
    }
    
    @IBAction func cancelCollection(_ sender: Any) {
        for btn in  self.radioButtonArray {
             btn.isSelected = false
                        }

        self.collectionListView.isHidden = true
    }
    
    
    //MARK:- Scrollview deleagte 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        //        if pos.y < 0 {
        //            self.navigationController?.navigationBar.isHidden = true
        //            self.navigationController?.navigationBar.alpha = 1
        //        }
        //        else {
        //            self.navigationController?.navigationBar.isHidden = false
        //            self.navigationController?.navigationBar.alpha = 0.5
        //
        //        }
        
        print(offset)
        
        if offset <= 730 {
            
//            let headerScaleFactor:CGFloat = -(offset) / headerView.bounds.height
//            let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height)/2.0
//            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
//            //headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
//            
//            headerView.layer.transform = headerTransform
            headerView.alpha = 0
        }
            
        else if (offset > 730) && (offset < 800) {
            headerView.frame .origin = CGPoint(x: headerView.frame.origin.x, y: headerView.frame.origin.y-1)
//            headerTransform = CATransform3DTranslate(headerTransform, 0,headerView.frame.origin.y+1 , 0)
            headerView.alpha = 1
            
        }
        //headerView.layer.transform = headerTransform
    }
    
    //MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == commentsTableView {
            return commentsArray.count
        }
        
        if isShowingDescription == false {
            return getRowCountForIngredients(coloumnKey:"ingradients")
        }
        return getRowCountForIngredients(coloumnKey:"description")

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.commentsTableView {
            let cell : CommentCell = tableView.dequeueReusableCell(withIdentifier: "commnetsCell") as! CommentCell
            
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let view =  cell?.viewWithTag(3)!
        
        
        view?.layer.borderColor = UIColor.gray.cgColor
        view?.layer.borderWidth = 1
        let label =  view?.viewWithTag(10) as! UILabel

        if let detail = postDetails {
            if isShowingDescription {
                label.text = "step\(indexPath.row+1) : " + (detail.descriptionArray[indexPath.row])   //( detail[key] as? String)!

            }
            else {
                label.text = "\(indexPath.row+1). " + (postDetails?.ingredientsArray[indexPath.row])! //( detail[key] as? String)!

            }
        }
        return cell!
    }

    
    func getRowCountForIngredients(coloumnKey:String)->Int {
        
        
        var lenghth = 0
        if let _ = self.postDetails {
            if coloumnKey == "description" {
                lenghth = (postDetails?.descriptionArray.count)!
            }
            else {
                lenghth = (postDetails?.ingredientsArray.count)!
            }
        }
        
        
        return lenghth
    }
    
    //MARK: - Update UI
    func UpdateUI() {
        self.userName.text = postDetails?.userName //["userName"] as? String
        self.postName.text = postDetails?.dishName //["dishName"] as? String
        if let loveCount = self.postDetails?.loves {
            self.noOfSmilesLabel.text = "\(loveCount)" //["loves"] as? String
        }
        if let collectionCount = self.postDetails?.difficulty {
            self.difficultyLabel.text = "\(collectionCount)" //["loves"] as? String
        }
        if let dishName = postDetails?.dishName {
            self.postName.text = dishName //["dishName"] as? String
            headingLabel.text = "How to prepare \(dishName)"
        }

        self.timeToCookLabel.text = postDetails?.efforts
        
        self.caloriesLabel.text = ""
        
        if let id = postDetails?.userId {
            let imgrl = "http://ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(id)/user.jpg"
            
            URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let data =  data1 {
                        self.userPic.image = UIImage(data: data)
                         self.userPic.layer.cornerRadius =  self.userPic.frame.size.width/2
                         self.userPic.layer.masksToBounds = true
                    }
                })
                }.resume()
            

        }
    

        
        URLSession.shared.dataTask(with: URL(string:(postDetails?.ImagePath1)!)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                if let imageData = data1 {
                    self.mainImageview.image = UIImage(data: imageData)
                    self.mainImageview.backgroundColor = UIColor.clear
                }
            })
            }.resume()
        

    }

    //MARK: - Button IBAction
    
    @IBAction func backBtnAction(_ sender: Any) {

        let _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func showCommwntsView(_ sender: Any) {
        commentsview.isHidden = false
        tapguesture?.isEnabled = true
        self.collectionLabel.textColor = UIColor.black
        self.commentsLabel.textColor = UIColor.white
        self.commentsview.isHidden = false
        if commentsArray.count == 0 {
            self.commentsview.isHidden = true
            tapguesture?.isEnabled = false
            Utility.showAlert(title: "MunchPic", message: "No comments", controller: self, completion: nil)
        }

    }
    
    @IBAction func showCollectioList(_ sender: Any) {
        collectionListView.isHidden = false
        tapguesture?.isEnabled = true
        self.collectionLabel.textColor = UIColor.white
        self.commentsLabel.textColor = UIColor.black
    }
    
    @IBAction func showIngredients(_ sender: Any) {
        isShowingDescription = false
        if let dishName = postDetails?.dishName {
            headingLabel.text = "\(dishName) Ingredients:"
        }
        

        self.tableView.reloadData()
    }

    @IBAction func showDifficultyView(_ sender: Any) {
        self.DifficultyView.isHidden = false
        tapguesture?.isEnabled = true

    }
    
    @IBAction func showDescription(_ sender: Any) {
        isShowingDescription = true
        if let dishName = postDetails?.dishName {
            headingLabel.text = "How to prepare \(dishName)"
        }
        
        self.tableView.reloadData()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text == "" {
            textView.text = "Add Comment"
            textView.textColor = UIColor.lightGray
            commentsViewChatImage.image = UIImage(named: "commentnew")
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        commentsViewChatImage.image = UIImage(named: "iconright")
        textView.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if textView.text == "Add Comment" && text != ""{
            textView.text = ""
            textView.textColor = UIColor.black
            commentsViewChatImage.image = UIImage(named: "iconright")
            
            
        }
        if textView.text == "Add Comment" && text == ""{
            return  false
        }
        return  true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    //MARK: - Comments actions
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
           // keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y =  -keyboardRectangle.height
        }
    }
    
    @IBAction func addComment(_ sender: Any) {
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let param = "userId=\(userId)" +
                "&postId=\(self.postDetails)" +
            "&comments=\(self.commentsTextView.text ?? "")"
            
            ServiceLayer.insertComments(parameter: param) { (response, status, msg) in
                print(msg)
                if status && msg == "Commented" {
                    DispatchQueue.main.async(execute: {
                        self.commentsview.isHidden = true
                        Utility.showAlert(title: "Muchpic", message:"Commented", controller: self,completion:nil)
                        
                    })
                    
                }
            }
        }
    }

}
