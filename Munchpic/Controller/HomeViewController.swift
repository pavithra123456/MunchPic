//
//  HomeViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import  MBProgressHUD

class HomeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate {
    
    
    @IBOutlet weak var commentsContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var commentsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionlistContainerView: UIView!
    
    @IBOutlet weak var commentsTableContainerView: UIView!
    @IBOutlet weak var commentsContainerView: UIView!
    @IBOutlet weak var commentsView: UIView!
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var commentsViewCahtImage: UIImageView!
    @IBOutlet weak var emojisView: UIView!
    @IBOutlet var Pagingimage: UIImageView!
    @IBOutlet var pagecontroller: UIPageControl!
    @IBOutlet var mscrollview: UIScrollView!
    @IBOutlet var Hometableview: UITableView!
    @IBOutlet var heightconstraint: NSLayoutConstraint!
    
    var selectedEmojiIndex = 0
    var selectedPostId = 0
    
    var commentsArray = [[String:AnyObject]] ()
    
    var slidearrayData:NSMutableArray = NSMutableArray()
    var mPosition:Int = Int()
    var myint = Int()
    var index = 0
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    var slidetimer: Timer!
    var postArray = [PostModel]()
    
    
    var radioButtonArray = [RadioButton]()
    
    @IBOutlet weak var radioBtn1: RadioButton!
    @IBOutlet weak var radioBtn2: RadioButton!
    @IBOutlet weak var radioBtn3: RadioButton!
    @IBOutlet weak var radioBtn4: RadioButton!
    @IBOutlet weak var radioBtn5: RadioButton!
    @IBOutlet weak var radioBtn6: RadioButton!
    
    
    var tapguesture : UITapGestureRecognizer?
    
    
    @IBOutlet weak var emojiViewHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      
        
        radioButtonArray = [radioBtn1,radioBtn2,radioBtn3,radioBtn4,radioBtn5,radioBtn6]
        
        
        self.Hometableview.estimatedRowHeight = 300
        self.Hometableview.isScrollEnabled = false
        self.Hometableview.delegate = self
        slidearrayData = ["1.png","2.png","3.png","1.png","2.png","3.png","1.png","2.png"]
        
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        self.swipeGestureLeft.addTarget(self, action:#selector(HomeViewController.handleSwipeLeft(gesture:)))
        self.swipeGestureRight.addTarget(self, action:#selector(HomeViewController.handleSwipeRight(gesture:)))
        mscrollview.addGestureRecognizer(self.swipeGestureLeft)
        mscrollview.addGestureRecognizer(self.swipeGestureRight)
        
        slidetimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector:#selector(HomeViewController.handleSwipeLeft(gesture:)), userInfo: nil, repeats: true)
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        //TODO: - Need Add nill check
        ServiceLayer.getPosts { (postArry, status, msg) in
            DispatchQueue.main.async(execute: {
              
                MBProgressHUD.hide(for: self.view, animated: true)
            })
            DispatchQueue.main.async(execute: {
                if let allPostArray = postArry {
                    self.postArray = allPostArray
                    self.Hometableview.reloadData()

                    self.Hometableview.beginUpdates()
                    self.Hometableview.endUpdates()
                }
            })
        }
        
        
        commentsContainerView.layer.cornerRadius = 8.0
        commentsContainerView.layer.borderWidth = 1
        
        commentsContainerView.layer.masksToBounds = true;
        commentsContainerView.layer.borderColor = UIColor(red: 230.0/255, green: 120/255, blue: 65/255, alpha: 1).cgColor
        
        //UIColor.red.cgColor
        addGuestures()
        
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewDidLayoutSubviews() {
        mscrollview.isScrollEnabled = true
        mscrollview.contentSize = CGSize(width: self.view.frame.size.width, height: Hometableview.contentSize.height+250)
    }
    
 
    
    //MARK: - Guestures
    
    func addGuestures() {
        tapguesture = UITapGestureRecognizer.init(target: self, action: #selector(hidePopUps))
        tapguesture?.isEnabled = false
        self.view.addGestureRecognizer(tapguesture!)
        
    }
    
    func hidePopUps() {
        self.commentsView.isHidden = true
        self.collectionlistContainerView.isHidden = true
        self.tapguesture?.isEnabled = false
        self.commentsTextView.resignFirstResponder()
       // self.commentsTableContainerView.frame.origin.y = self.commentsView.frame.height/2 - 100
        
    }
    
    //MARK: - Radio Button Actions
    
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
    
    @IBAction func showCollections(_ sender: Any) {
        collectionlistContainerView.isHidden = false
        tapguesture?.isEnabled = true
        
    }
    
    @IBAction func collectionOkAction(_ sender: Any) {
        collectionlistContainerView.isHidden = true
        tapguesture?.isEnabled = false
    }
    
    
    @IBAction func collectionCancelAction(_ sender: Any) {
        collectionlistContainerView.isHidden = true
        tapguesture?.isEnabled = false
    }
    
    
    
    //MARK: - Pagecontroller
    @IBAction func Pagecontroller_Action(_ sender: Any) {
        
        let servicesList1: (AnyObject) = (slidearrayData[(pagecontroller.currentPage)] as AnyObject)
        Pagingimage.image = UIImage(named: servicesList1 as! String)
        mPosition = pagecontroller.currentPage
    }
    
    //Left gesture
    func handleSwipeLeft(gesture: UISwipeGestureRecognizer){
        
        if pagecontroller.currentPage < slidearrayData.count-1 {
            pagecontroller.currentPage += 1
            let servicesList1: (AnyObject) = (slidearrayData[(pagecontroller.currentPage)] as AnyObject)
            Pagingimage.image = UIImage(named: servicesList1 as! String)
            mPosition = pagecontroller.currentPage
        }else{
            pagecontroller.currentPage = 0
            let servicesList1: (AnyObject) = (slidearrayData[(pagecontroller.currentPage)] as AnyObject)
            Pagingimage.image = UIImage(named: servicesList1 as! String)
            mPosition = pagecontroller.currentPage
            
        }
    }
    
    // Right gesture
    func handleSwipeRight(gesture: UISwipeGestureRecognizer){
        
        if pagecontroller.currentPage != 0 {
            pagecontroller.currentPage -= 1
            let servicesList1: (AnyObject) = (slidearrayData[(pagecontroller.currentPage)] as AnyObject)
            Pagingimage.image = UIImage(named: servicesList1 as! String)
            mPosition = pagecontroller.currentPage
            
        }else{
            
            pagecontroller.currentPage = slidearrayData.count
            let servicesList1: (AnyObject) = (slidearrayData[(pagecontroller.currentPage)] as AnyObject)
            Pagingimage.image = UIImage(named: servicesList1 as! String)
            mPosition = pagecontroller.currentPage
            
        }
        
        
    }
    
    //MARK: - TableView Deleagte
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.commentsTableView {
            return self.commentsArray.count
        }
        return self.postArray.count
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
        else {
            var cell : CustomTableViewCell! = Hometableview.dequeueReusableCell(withIdentifier: "Hcell") as! CustomTableViewCell
            if(cell == nil)
            {
                cell = Bundle.main.loadNibNamed("Hcell", owner: self, options: nil)?[0] as! CustomTableViewCell;
            }
            
            cell.configureCell(model: postArray[indexPath.row])
            
            cell.likeButton.tag = indexPath.row
            cell.commentBtn.tag = indexPath.row
            cell.ShowSmilyBtn.tag = indexPath.row
            
            if postArray[indexPath.row].lovesStatus != "0" {
                let imageStr = "emoji\(postArray[indexPath.row].lovesStatus)"
                cell.likeButton.setImage(UIImage(named:imageStr), for: .normal)
                
            }
            
//            let mainImgUrl =  "http://www.ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(postArray[indexPath.row].userId)/\(postArray[indexPath.row].postId)_post1.jpg"
            
            URLSession.shared.dataTask(with: URL(string:postArray[indexPath.row].ImagePath1)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let imageData = data1 {
                        cell.foodrecipeImage.image = UIImage(data: imageData)
                        //cell.foodrecipeImage.backgroundColor = UIColor.clear
                    }
                })
                }.resume()
            
            
            
            let imgrl = "http://ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(postArray[indexPath.row].userId)/user.jpg"
            URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let data =  data1 {
                        cell.profilePic.image = UIImage(data: data)
                        cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                        cell.profilePic.layer.masksToBounds = true
                    }
                })
                }.resume()
            
//            mscrollview.isScrollEnabled = true
//            mscrollview.isUserInteractionEnabled = true
//            
          
//            Hometableview.frame.size.height = Hometableview.contentSize.height
            heightconstraint.constant = Hometableview.contentSize.height
            mscrollview.contentSize = CGSize(width: self.view.frame.size.width, height: Hometableview.contentSize.height+250)
            
            
            return cell
            
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPostId = postArray[indexPath.row].postId
        let detailVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        detailVc.postDetails = postArray[indexPath.row]
        detailVc.postId = selectedPostId
        UserDefaults.standard.set(false, forKey: "editvisible")
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
    
    //MARK: - Custom cell Actions
    
    
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: ["" as NSString], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: {})
    }
    
    //MARK: - EMojis Actions
   
    
    //MARK: - Comments Actions
    
    @IBAction func addComment(_ sender: Any) {
        if self.commentsTextView.text == "Add Comment" {
            Utility.showAlert(title: "MunchPic", message: "Please add comment", controller: self, completion: nil)
            return
        }
        
        if(self.commentsTextView.text.characters.count == 0){
            
            Utility.showAlert(title: "MunchPic", message: "Please add comment", controller: self, completion: nil)
            return
            
        }
        
        self.commentsTextView.resignFirstResponder()

        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let param = "userId=\(userId)" +
                "&postId=\(selectedPostId)" +
            "&comments=\(self.commentsTextView.text ?? "")"
            
            ServiceLayer.insertComments(parameter: param) { (response, status, msg) in
                print(msg)
                if status && msg == "Commented" {
                    DispatchQueue.main.async(execute: {
                        self.commentsView.isHidden = true
                        Toast.showToast(text: "Commented", toView: self.view)
                        //Utility.showAlert(title: "Muchpic", message:"Commented", controller: self,completion:nil)
                        
                    })
                    
                }
            }
        }
    }
    
    @IBAction func commentButtonAction(_ sender: Any) {
        commentsTextView.text = "Add Comment"
        commentsTextView.textColor = UIColor.lightGray
        commentsViewCahtImage.image = UIImage(named: "commentnew")
        
        self.tapguesture?.isEnabled = true
        let index = (sender as! UIButton).tag
        selectedPostId = postArray[index].postId
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ServiceLayer.GetComments(forPostId:selectedPostId) { (response, status, mess) in
            
            DispatchQueue.main.async(execute: {
                
                MBProgressHUD.hide(for: self.view, animated: true)
            })
            
            if let resCommentsArray = response {
                self.commentsArray = resCommentsArray
                
            }
            
            DispatchQueue.main.async(execute: {
                self.commentsView.isHidden = false
                if self.commentsArray.count == 0 {
                    self.commentsTableViewHeight.constant = 0
                    self.commentsContainerHeight.constant = 80
                    self.commentsView.layoutIfNeeded()
                    Toast.showToast(text: "No Comments", toView: self.view)

                }
                else {
                    self.commentsTableViewHeight.constant = 168
                    self.commentsContainerHeight.constant = 252
                    self.commentsView.layoutIfNeeded()
                }
                
                self.commentsTableView.reloadData()
            })
        }
    }
    //MARK: - Textview Delegates
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text == "" {
            textView.text = "Add Comment"
            textView.textColor = UIColor.lightGray
            commentsViewCahtImage.image = UIImage(named: "commentnew")
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        commentsViewCahtImage.image = UIImage(named: "iconright")
        textView.text = ""
        self.commentsTableContainerView.frame.origin.y = self.commentsTableContainerView.frame.origin.y
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if textView.text == "Add Comment" && text != ""{
            textView.text = ""
            textView.textColor = UIColor.black
            commentsViewCahtImage.image = UIImage(named: "iconright")
            
            
        }
        if textView.text == "Add Comment" && text == ""{
            return  false
        }
        return  true
    }
    
    //MARK: - Other
    
    @IBAction func cameraAction(_ sender: Any) {
        
        self.parent?.performSegue(withIdentifier: "showNewPost", sender: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail1" {
            let detaILVC = segue.destination as! DetailViewController
            detaILVC.postId = selectedPostId
            detaILVC.postDetails = sender as! PostModel
            selectedPostId = 0
        }
        if segue.identifier == "ShowSmilyView" {
            let detaILVC = segue.destination as! SmilesViewController
            
            if let _ = sender {
                let button = sender as! UIButton
                detaILVC.postDetail = postArray[button.tag]
            }
            
        }
        
    }
    
    //MARK: - Comments actions
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.commentsTableContainerView.frame.origin.y = self.commentsTableContainerView.frame.origin.y - (keyboardRectangle.height - commentsTableContainerView.frame.origin.y)
            print(keyboardRectangle.height - commentsTableContainerView.frame.origin.y)
            //print((commentsTableContainerView.frame.origin.y))
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.commentsTableContainerView.frame.origin.y = self.commentsView.frame.height/2 - 50

        }
    }
    
}


