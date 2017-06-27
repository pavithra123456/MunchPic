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
    
    @IBOutlet var Pagingimage: UIImageView!
    @IBOutlet var pagecontroller: UIPageControl!
    @IBOutlet var mscrollview: UIScrollView!
    @IBOutlet var Hometableview: UITableView!
    @IBOutlet var heightconstraint: NSLayoutConstraint!
    let images = ["img0","img1","img2","","","",""]
    
    
    var slidearrayData:NSMutableArray = NSMutableArray()
    var mPosition:Int = Int()
    var myint = Int()
    var index = 0
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    var slidetimer: Timer!
    var postArray = [PostModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
                    

                    self.postArray.append(model)
                }
            }
            self.Hometableview.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        mscrollview.isScrollEnabled = true
        mscrollview.contentSize = CGSize(width: self.view.frame.size.width, height: Hometableview.contentSize.height+250)
    }
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : CustomTableViewCell! = Hometableview.dequeueReusableCell(withIdentifier: "Hcell") as! CustomTableViewCell
        if(cell == nil)
        {
            cell = Bundle.main.loadNibNamed("Hcell", owner: self, options: nil)?[0] as! CustomTableViewCell;
        }
        
        cell.userName.text = postArray[indexPath.row].userName
        cell.description1.text = postArray[indexPath.row].description1
        cell.loves.text = "\(postArray[indexPath.row].loves)"
        cell.comments.text = "\(postArray[indexPath.row].comments)"
        cell.useId = postArray[indexPath.row].userId
        
        
//        let servicesList1: (AnyObject) = (slidearrayData[indexPath.row] as AnyObject)
//        cell.foodrecipeImage.image = UIImage(named: images[indexPath.row] )
        URLSession.shared.dataTask(with: URL(string:postArray[indexPath.row].ImagePath1)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                cell.foodrecipeImage.image = UIImage(data: data1!)
            })
        }.resume()
        
        let imgrl = "http://ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(postArray[indexPath.row].userId)/user.jpg"
        URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                cell.profilePic.image = UIImage(data: data1!)
            })
            }.resume()
        
        
        mscrollview.isScrollEnabled = true
        mscrollview.isUserInteractionEnabled = true
        
        mscrollview.contentSize = CGSize(width: self.view.frame.size.width, height: Hometableview.contentSize.height+250)
        Hometableview.frame.size.height = Hometableview.contentSize.height
        heightconstraint.constant = Hometableview.frame.size.height
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

      
    @IBAction func addComments(_ sender: Any) {
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


