//
//  ProfileViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
enum CollectionCategory :String {
    case FastFood
    case Sweets
    case Gravy
    case Deserts
    case NonVeg
    case MyFavourtites
}

class ProfileViewController: UIViewController,UIScrollViewDelegate{
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var mscrollview: UIScrollView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var lovesTableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userPostsTableView: UITableView!
    @IBOutlet weak var tableview: UITableView!
    let images = ["food1","food2","food3","food4","img1","img0","img2","food5"]
    @IBOutlet var headerView: UIView!
    var collectionArray = [[String:String]]()
    var lovesArray = [ProfilkeLovesModel]()
    var userPostsArray = [PostModel]()
    var collectionViewDataValue = "posts"
    
    @IBOutlet weak var tableviewheight: NSLayoutConstraint!
    @IBOutlet weak var collectionviewheight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lovesTableView.delegate = self
        lovesTableView.dataSource = self
        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        
        //        self.collectionview.register( UINib(nibName: "ProfileHeaderView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "profileHeader")
        //        self.collectionview.reloadData()
        
        // Do any additional setup after loading the view.
        
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let imgrl = "http://ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(String(describing: userId))/user.jpg"
            URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let data =  data1 {
                        if let img = UIImage(data: data) {
                            self.profilePic.image =  img //UIImage(data: data)
                           
                        }
                        self.profilePic.layoutIfNeeded()
                        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2
                        self.profilePic.layer.masksToBounds = true
                        self.profilePic.layer.borderColor = UIColor.white.cgColor
                         self.profilePic.layer.borderWidth = 1.0
                        
                    }
                })
                }.resume()
            
            
        }
        if let userName =  UserDefaults.standard.value(forKey: "name") {
            self.profileName.text = userName as? String
        }
        
        getUserPosts()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        mscrollview.contentSize.height = self.profileName.frame.origin.y + collectionView.frame.height + 110

        collectionView.isHidden = false
        self.cameraButtonAction(nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // mscrollview.contentSize.height = self.view.frame.size.height
        self.getCollectioncategories()
        self.getLoves()
        self.getUserPosts()
       
//        if lovesTableView.isHidden == true{
//            
//            self.collectionView.isHidden = false
//            collectionView.reloadData()
//            
//        }else if collectionView.isHidden == true{
//            let button = UIButton()
//            self.lovesButtonAction(button)
//            
//        }
        
        collectionView.isHidden = false
        lovesTableView.isHidden = true
        collectionView.reloadData()
        if lovesTableView.isHidden {
            self.collectionView.isHidden = false
        }
    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        
//        if lovesTableView.isHidden == true{
//            self.collectionView.isHidden = false
//            collectionView.reloadData()
//        }else if collectionView.isHidden == true{
//            self.getLoves()
//            self.lovesTableView.isHidden = false
//            lovesTableView.reloadData()
//        }
//        
//    }
    
    
    func getUserPosts () {
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            ServiceLayer.getUserPosts(relativeUrl: "userId=\(userId)") { (response, status, msg) in
                self.userPostsArray.removeAll()
                for post in response! {
                    let postobject = post
                    let model = PostModel()
                    model.postId = Int(postobject["postId"] as! String)!
                    model.userName = postobject["userName"] as! String
                    model.ImagePath1 = postobject["ImagePath1"] as! String
                    model.dishName = postobject["dishName"] as! String
                    
                    model.postId = Int(postobject["postId"] as? String ?? "0")!
                    model.userName = postobject["userName"] as? String ?? ""
                    model.dishName = postobject["dishName"] as? String ?? ""
                    
                    
                    model.descriptionArray.append(postobject["description1"] as? String ?? "")
                    var coloumnKey = "description"
                    for i in 1...10 {
                        let key = "\(coloumnKey)\(i)"
                        if let value =  postobject[key]  as? String{
                            if value == "" {
                                continue
                            }
                            model.descriptionArray.append(value)
                        }
                    }
                    
                    coloumnKey = "ingradients"
                    for i in 1...16 {
                        let key = "\(coloumnKey)\(i)"
                        if let value =  postobject[key]  as? String{
                            if value == "" {
                                continue
                            }
                            model.ingredientsArray.append(value)
                        }
                    }
                    
                    
                    model.ImagePath1 = postobject["ImagePath1"] as? String ?? ""
                    if let loveCount =  Int(postobject["loves"] as? String ?? "0") {
                        model.loves = loveCount
                    }
                    
                    model.comments = Int(postobject["comments"] as? String ?? "0")!
                    model.userId = Int(postobject["userId"] as! String )!
                    model.noOfCollection = Int(postobject["collections"] as? String ?? "0")!
                    model.comments = Int(postobject["comments"] as? String ?? "0")!
                    
                    model.efforts = postobject["difficulty"] as? String ?? ""
                    model.difficulty = postobject["difficulty"] as? String ?? ""
                    
                    model.love1 = postobject["love1"] as? String ?? ""
                    model.love2 = postobject["love2"] as? String ?? ""
                    model.love3 = postobject["love3"] as? String ?? ""
                    model.love4 = postobject["love4"] as? String ?? ""
                    model.love5 = postobject["love5"] as? String ?? ""
                    model.love6 = postobject["love6"] as? String ?? ""
                    model.lovesStatus = postobject["lovesStatus"] as? String ?? ""
                    self.userPostsArray.append(model)
                }
                DispatchQueue.main.async {
                   
                    self.collectionView.isHidden = false
                    
                    self.collectionView.reloadData()
                    
                }
                
            }
        }
        
    }
    
    func getCollectioncategories() {
        ServiceLayer.getCollectionCategories { (data, status, msg) in
            self.collectionArray = data as! [[String : String]]
            DispatchQueue.main.async(execute: {
                self.collectionView.reloadData()
            })
        }
    }
    
    func getLoves() {
        ServiceLayer.getLoves { (lovesArray, status, msg) in
            self.lovesArray = lovesArray!
            DispatchQueue.main.async(execute: {
                self.lovesTableView.reloadData()
            })
        }
    }
    
    //MARK: - ButtonActions
    
    @IBAction func collectionButtonAction(_ sender: Any?) {
        mscrollview.contentSize.height = self.view.frame.size.height
        self.getCollectioncategories()
        self.lovesTableView.isHidden = true
        self.collectionView.isHidden = false
        collectionViewDataValue = "collection"
       // collectionView.reloadData()
        
    }
    
    @IBAction func cameraButtonAction(_ sender: Any?) {
        mscrollview.contentSize.height = self.view.frame.size.height
        getUserPosts()
        self.lovesTableView.isHidden = true
        self.collectionView.isHidden = false
        collectionViewDataValue = "posts"
        self.collectionView.reloadData()
    }
    
    @IBAction func lovesButtonAction(_ sender: Any) {
        mscrollview.contentSize.height = self.view.frame.size.height
        self.getLoves()
        self.lovesTableView.isHidden = false
        self.collectionView.isHidden = true
        lovesTableView.reloadData()
    }
    
    @IBAction func aboutAction(_ sender: Any) {
        self.parent?.performSegue(withIdentifier: "showAbout", sender: nil)
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "editvisible")
        
        //UserDefaults.standard.bool(forKey: "editvisible") == true
        self.parent?.performSegue(withIdentifier: "addNewPost", sender: nil)
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

extension ProfileViewController:UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lovesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if cell is LovesTableViewCell {
            let loveCell =  cell as! LovesTableViewCell
            loveCell.postName.text = lovesArray[indexPath.row].dishName
            loveCell.creationDateLabel.text = lovesArray[indexPath.row].dateSaved
            
            
            
            let imgrl =  "http://www.ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(lovesArray[indexPath.row].postedUserId)/\(lovesArray[indexPath.row].postId)_post1.jpg"
            
            URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let data =  data1 {
                        loveCell.postImage.image = UIImage(data: data)
                    }
                })
                }.resume()
            
            
            tableviewheight.constant = lovesTableView.contentSize.height
            mscrollview.contentSize.height = lovesTableView.contentSize.height + 250
        }
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let storyboad = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailVc = storyboad.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        detailVc.postId = Int(lovesArray[indexPath.row].postId)!
        detailVc.isDetaiLForLovedPost = true
        UserDefaults.standard.set(false, forKey: "editvisible")
        self.navigationController?.pushViewController(detailVc, animated: true)
        
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate ,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionViewDataValue == "posts" {
            return  userPostsArray.count/2
        }
        return  collectionArray.count/2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for:indexPath) as! CustomCollectionViewCell
        let section = indexPath.section * 2
        
        if collectionViewDataValue == "posts" && userPostsArray.count != 0 {
            var obj = userPostsArray[indexPath.row]
            if indexPath.row == 0  && userPostsArray.count != 0 {
                obj = userPostsArray[ section]
            }
            else {
                obj = userPostsArray[1 + section]
            }
            
            if indexPath.section % 2 == 0 {
                
                if indexPath.row == 0 {
                    cell.menuImage.backgroundColor = UIColor(red: 125, green: 138, blue: 50)
                }
                else {
                    cell.menuImage.backgroundColor = UIColor(red: 158, green: 107, blue: 58)
                }
                
                
            }
            else {
                
                
                if indexPath.row == 0 {
                    
                    cell.menuImage.backgroundColor = UIColor(red: 158, green: 107, blue: 58)
                }
                else {
                    cell.menuImage.backgroundColor = UIColor(red: 125, green: 138, blue: 50)
                }
                
            }
            
            
            URLSession.shared.dataTask(with: URL(string:obj.ImagePath1)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let imageData = data1 {
                        cell.menuImage.image = UIImage(data: imageData)
                    }
                })
                }.resume()
            
            cell.nameLabel.text = "" //userPostsArray[indexPath.row].dishName
            
            collectionviewheight.constant = collectionView.contentSize.height
            mscrollview.contentSize.height = collectionView.contentSize.height + 250

        }
            
        else {
            var obj = collectionArray[indexPath.row]
            if indexPath.row == 0 {
                obj = collectionArray[ section]
                //cell.nameLabel.backgroundColor =
                if indexPath.section % 2 == 0 {
                   
                    if indexPath.row == 0 {
                        cell.nameLabel.backgroundColor = UIColor(red: 125, green: 138, blue: 50)
                    }
                    else {
                        cell.nameLabel.backgroundColor = UIColor(red: 158, green: 107, blue: 58)
                    }

                    
                }
                else {
                    
                    
                    if indexPath.row == 0 {
                        
                        cell.nameLabel.backgroundColor = UIColor(red: 158, green: 107, blue: 58)
                    }
                    else {
                       cell.nameLabel.backgroundColor = UIColor(red: 125, green: 138, blue: 50)
                    }

                }
            }
            else {
                obj = collectionArray[1 + section]
            }
            URLSession.shared.dataTask(with: URL(string:obj["categoryImage"]!)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let imageData = data1 {
                        cell.menuImage.image = UIImage(data: imageData)
                        cell.nameLabel.backgroundColor = UIColor.clear
                        cell.labelTopHeight.constant = cell.frame.size.height/2 - 20
                    }
                })
                }.resume()
            cell.nameLabel.text = obj["categoryName"]
            
            collectionviewheight.constant = collectionView.contentSize.height
            mscrollview.contentSize.height = collectionView.contentSize.height + 250

            
        }
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width/2-1, height:  150)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = indexPath.section * 2
        
        if collectionViewDataValue == "posts" {
            var obj = userPostsArray[indexPath.row]
            if indexPath.row == 0 {
                obj = userPostsArray[ section]
            }
            else {
                obj = userPostsArray[1 + section]
            }
            
            let storyboad = UIStoryboard(name: "Main", bundle: Bundle.main)
            let detailVc = storyboad.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
            detailVc.postDetails = obj
            detailVc.postId = obj.postId // lovesArray[indexPath.row].postId
            detailVc.isPostEditable = true
            UserDefaults.standard.set(true, forKey: "editvisible")
            self.navigationController?.pushViewController(detailVc, animated: true)
            return
            
            
        }
        
        let storyBoard = UIStoryboard(name: "UserPosts", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UserCllectionListCntrl") as!UserCollectionListController
        
        var obj:AnyObject?
        if indexPath.row == 0 {
            obj = collectionArray[ section] as AnyObject
        }
        else {
            obj = collectionArray[1 + section] as AnyObject
        }
        
        vc.toCategory = (obj?["categoryName"] as! String) //((CollectionCategory.init(rawValue:(obj?["categoryName"] as! String).replacingOccurrences(of: " ", with: "")))?.rawValue)!
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */





