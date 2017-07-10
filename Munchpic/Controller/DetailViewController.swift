//
//  DetailViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mainImageview: UIImageView!
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPic: UIImageView!
    
    
    @IBOutlet weak var commentsview: UIView!
    @IBOutlet weak var collectionListView: UIView!
    
    var postId = 0
    var postDetails :[String:AnyObject]?
    var isShowingDescription = true
    
    
    var tapguesture : UITapGestureRecognizer?
    var commentsArray = [[String:AnyObject]] ()

    @IBOutlet weak var commentsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var commentsTableView: UITableView!
    
    @IBOutlet weak var commentsContainerHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var commentsTextviewContainer: UIView!
    
    var radioButtonArray = [RadioButton]()
    
    @IBOutlet weak var radioBtn1: RadioButton!
    @IBOutlet weak var radioBtn2: RadioButton!
    @IBOutlet weak var radioBtn3: RadioButton!
    @IBOutlet weak var radioBtn4: RadioButton!
    @IBOutlet weak var radioBtn5: RadioButton!
    @IBOutlet weak var radioBtn6: RadioButton!
    
    @IBOutlet weak var noOfCollectionLabel: UILabel!
    @IBOutlet weak var noOfCommentsLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var noOfSmilesLabel: UILabel!
    @IBOutlet weak var timeToCookLabel: UILabel!
    
    @IBOutlet weak var headingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.estimatedRowHeight = 15
        ServiceLayer.getPostDetails(forPostId: postId) { (responseArray , status, msg) in
            if status == true && (responseArray?.count)! > 0 {
                self.postDetails = responseArray?[0]
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    self.UpdateUI()
                })
            }
           
        }
        
        commentsTableView.dataSource = self
    
        addGuestures()
        getcooments()
        addBorderToCommentsView()
        
        radioButtonArray = [radioBtn1,radioBtn2,radioBtn3,radioBtn4,radioBtn5,radioBtn6]

        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func addBorderToCommentsView() {
        commentsTextviewContainer.layer.cornerRadius = 8.0
        commentsTextviewContainer.layer.borderWidth = 1
        
        commentsTextviewContainer.layer.masksToBounds = true;
        commentsTextviewContainer.layer.borderColor = UIColor.red.cgColor
    }
    
    func getcooments() {
        ServiceLayer.GetComments(forPostId:postId) { (response, status, mess) in
            
            if let resCommentsArray = response {
                self.commentsArray = resCommentsArray
            }
            
            DispatchQueue.main.async(execute: {
                //self.commentsview.isHidden = false
                if self.commentsArray.count == 0 {
                    self.commentsTableViewHeight.constant = 0
                    self.commentsContainerHeight.constant = 90
                    self.commentsview.layoutIfNeeded()
                }
                else {
                    self.commentsTableViewHeight.constant = 168
                    self.commentsContainerHeight.constant = 252
                    self.commentsview.layoutIfNeeded()
                }
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
        scrollview.contentSize = CGSize(width: self.view.frame.width, height: 1500)

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
        
        
        view?.layer.borderColor = UIColor.red.cgColor
        view?.layer.borderWidth = 1
        let label =  view?.viewWithTag(10) as! UILabel

        if let detail = postDetails {
            if isShowingDescription {
                let key = "description\(indexPath.row+1)"
                label.text = detail[key] as? String

            }
            else {
                let key = "ingradients\(indexPath.row+1)"
                label.text = detail[key] as? String
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
        self.userName.text = postDetails?["userName"] as? String
        self.postName.text = postDetails?["dishName"] as? String
        
        self.noOfSmilesLabel.text = postDetails?["loves"] as? String
        self.timeToCookLabel.text = postDetails?["effort"] as? String
        self.caloriesLabel.text = postDetails?["calories"] as? String
        noOfCollectionLabel.text = postDetails?["collections"] as? String
        noOfCommentsLabel.text = postDetails?["comments"] as? String
        if let name = postDetails?["dishName"] {
            headingLabel.text = "How to prepare \(name))"

        }


        
        let  userId  = Int(postDetails?["userId"] as! String)!

        let imgrl = "http://ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(userId)/user.jpg"

        URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                if let data =  data1 {
                    self.userPic.image = UIImage(data: data)
                }
            })
            }.resume()

        
        URLSession.shared.dataTask(with: URL(string:postDetails?["ImagePath1"] as! String)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                if let imageData = data1 {
                    self.mainImageview.image = UIImage(data: imageData)
                }
            })
            }.resume()
        
        
    }
    
    //MARK: - Button IBAction
    
    @IBAction func backBtnAction(_ sender: Any) {
        let appdelegate =  (UIApplication.shared.delegate as! AppDelegate)

        appdelegate.isForWindowDetailView = false
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)

        let _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func showCommwntsView(_ sender: Any) {
        commentsview.isHidden = false
        tapguesture?.isEnabled = true
    }
    
    @IBAction func showCollectioList(_ sender: Any) {
        collectionListView.isHidden = false
        tapguesture?.isEnabled = true
    }
    
    @IBAction func showIngredients(_ sender: Any) {
        isShowingDescription = false
        if let name = postDetails?["dishName"] {
            headingLabel.text = "\(name) Ingredients:"

            
        }

        self.tableView.reloadData()
    }

    @IBAction func showDescription(_ sender: Any) {
        isShowingDescription = true
        if let name = postDetails?["dishName"]
        {
            headingLabel.text = "How to prepare \(name):"
            
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        if segue.identifier == "showUserPosts" {
            let userPostVc = (segue.destination as! UINavigationController).viewControllers[0] as! UserPostsController
            //userPostVc.viewControllers[0]
            userPostVc.selectedUSerID = Int(postDetails?["userId"] as! String)!

        }
    }
 

}
