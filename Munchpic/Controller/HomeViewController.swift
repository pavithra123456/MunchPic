//
//  HomeViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import  MBProgressHUD

class HomeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var commentsContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var commentsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionlistContainerView: UIView!
    
    @IBOutlet weak var commentsTableContainerView: UIView!
    @IBOutlet weak var commentsContainerView: UIView!
    @IBOutlet weak var commentsView: UIView!
    
    @IBOutlet weak var commentsTableView: UITableView!
    
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
        self.Hometableview.delegate = self
        slidearrayData = ["1.png","2.png","3.png","1.png","2.png","3.png","1.png","2.png"]
        
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        self.swipeGestureLeft.addTarget(self, action:#selector(HomeViewController.handleSwipeLeft(gesture:)))
        self.swipeGestureRight.addTarget(self, action:#selector(HomeViewController.handleSwipeRight(gesture:)))
        mscrollview.addGestureRecognizer(self.swipeGestureLeft)
        mscrollview.addGestureRecognizer(self.swipeGestureRight)
        
        slidetimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector:#selector(HomeViewController.handleSwipeLeft(gesture:)), userInfo: nil, repeats: true)
        let url = Constants.kBaseUrl + Constants.kGetPost + "userId=\(38)"
        
        MBProgressHUD.showAdded(to: self.view, animated: true)

        ServiceLayer.getPosts( relativeUrl:url) { (response, true, message) in
            MBProgressHUD.hide(for: self.view, animated: true)

            let response1 = response as! [String:AnyObject]
            if let array = response1["result"] as? Array<Any> {
                for post in array {
                    let postobject = post  as! [String:AnyObject]
                    let model = PostModel()
                    model.postId = Int(postobject["postId"] as! String)!
                    model.userName = postobject["userName"] as! String
                    model.description1 = postobject["description1"] as! String
                    model.ImagePath1 = postobject["ImagePath1"] as! String
                    model.loves = Int(postobject["loves"] as! String)!
                    model.comments = Int(postobject["comments"] as! String)!
                    model.userId = Int(postobject["userId"] as! String)!
                    model.noOfCollection = Int(postobject["collections"] as! String)!
                    model.efforts = postobject["difficulty"] as! String

                    self.postArray.append(model)
                }
            }
            self.Hometableview.reloadData()
        }
        
        commentsContainerView.layer.cornerRadius = 8.0
        commentsContainerView.layer.borderWidth = 1
        
        commentsContainerView.layer.masksToBounds = true;
        commentsContainerView.layer.borderColor = UIColor(red: 230.0/255, green: 120/255, blue: 65/255, alpha: 1).cgColor
            
            //UIColor.red.cgColor
        addGuestures()
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
            
            cell.userName.text = postArray[indexPath.row].userName
            cell.description1.text = postArray[indexPath.row].description1
            //cell.loves.text = "\(postArray[indexPath.row].loves)"
            //cell.collectionCount.text = "\(postArray[indexPath.row].noOfCollection)"
            cell.useId = postArray[indexPath.row].userId
            cell.efforts  = postArray[indexPath.row].efforts
            cell.emojiImage.tag = indexPath.row
            cell.commentBtn.tag = indexPath.row
            URLSession.shared.dataTask(with: URL(string:postArray[indexPath.row].ImagePath1)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let imageData = data1 {
                        cell.foodrecipeImage.image = UIImage(data: imageData)
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
            
            mscrollview.isScrollEnabled = true
            mscrollview.isUserInteractionEnabled = true
            
            mscrollview.contentSize = CGSize(width: self.view.frame.size.width, height: Hometableview.contentSize.height+250)
            Hometableview.frame.size.height = Hometableview.contentSize.height
            heightconstraint.constant = Hometableview.frame.size.height
            
            
            return cell

        }

        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPostId = postArray[indexPath.row].postId
        self.performSegue(withIdentifier: "showDetail1", sender: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
    
    //MARK: - Custom cell Actions
    
    @IBAction func addComments(_ sender: Any) {
        
    }
   
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: ["" as NSString], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: {})
    }

    @IBAction func emojisBtnAction(_ sender: Any) {
        selectedEmojiIndex = (sender as! UIButton).tag
        
        
        let cell = self.Hometableview.cellForRow(at: IndexPath(item: self.selectedEmojiIndex, section: 0)) as! CustomTableViewCell
cell.smilesView .isHidden = !cell.smilesView.isHidden
        
//        self.emojisView.isHidden = false
//        UIView.animate(withDuration: 0.2, animations: { () -> Void in
//            self.emojiViewHeight.constant = self.view.frame.height/2 + 20
//            self.view.layoutIfNeeded()
//        })
    }
    
    @IBAction func updateEmoi(_ sender: Any) {
        let index = (sender as! UIButton).tag

        UIView.animate(withDuration: 0.2, delay: 0.2, options: [.repeat, .curveEaseInOut], animations: {}, completion:{ (status) -> Void in
            self.emojisView.isHidden = true
            self.emojiViewHeight.constant = -45
            
            let cell = self.Hometableview.cellForRow(at: IndexPath(item: self.selectedEmojiIndex, section: 0)) as! CustomTableViewCell
            let image = UIImage(named: "emoji\(index).png")
            cell.emojiImage.setImage(image, for: .normal)
            
        })

    
    }
    
    @IBAction func commentButtonAction(_ sender: Any) {
        self.tapguesture?.isEnabled = true
        let index = (sender as! UIButton).tag
        let postid = postArray[index].postId
        ServiceLayer.GetComments(forPostId:postid) { (response, status, mess) in
        
            if let resCommentsArray = response {
                self.commentsArray = resCommentsArray
               
            }
            
            DispatchQueue.main.async(execute: {
                self.commentsView.isHidden = false
                if self.commentsArray.count == 0 {
                    self.commentsTableViewHeight.constant = 0
                    self.commentsContainerHeight.constant = 80
                    self.commentsView.layoutIfNeeded()
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
    //MARK: - Other

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail1" {
            let appdelegate =  (UIApplication.shared.delegate as! AppDelegate)
            appdelegate.isForWindowDetailView = true
            let detaILVC = segue.destination as! DetailViewController
            detaILVC.postId = selectedPostId
            selectedPostId = 0
        }
    }
    
}


