//
//  ProfileViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
enum CollectionCategory :String {
    case FastFood = "Fast Food"
    case Sweets
    case Gravy
    case NonVeg
    case MyFavourtites
    
    
}
class ProfileViewController: UIViewController,UICollectionViewDataSource{
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
    var collectionViewDataValue = ""

    @IBOutlet weak var tableviewheight: NSLayoutConstraint!
    @IBOutlet weak var collectionviewheight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       collectionView.dataSource = self
        collectionView.delegate = self
        lovesTableView.delegate = self
//        self.collectionview.register( UINib(nibName: "ProfileHeaderView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "profileHeader")
//        self.collectionview.reloadData()
        
        // Do any additional setup after loading the view.
        
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let imgrl = "http://ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(String(describing: userId))/user.jpg"
            URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let data =  data1 {
                        self.profilePic.image = UIImage(data: data)
                        self.profilePic.layoutIfNeeded()
                        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2
                        self.profilePic.layer.masksToBounds = true
                    }
                })
                }.resume()

            
        }

        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        self.getCollectioncategories()
        getLoves()
        getUserPosts()
    }
    
    func getUserPosts () {
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            ServiceLayer.getUserPosts(relativeUrl: "userId=\(userId)") { (response, status, msg) in
                for post in response! {
                    let postobject = post
                    let model = PostModel()
                    model.postId = Int(postobject["postId"] as! String)!
                    model.userName = postobject["userName"] as! String
                    model.ImagePath1 = postobject["ImagePath1"] as! String
                    model.dishName = postobject["dishName"] as! String
                    
                    self.userPostsArray.append(model)
                }
                DispatchQueue.main.async {
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
            self.lovesTableView.reloadData()
        }
    }
    
    //MARK: - ButtonActions
    
    @IBAction func collectionButtonAction(_ sender: Any) {
        mscrollview.contentSize.height = self.view.frame.size.height
        self.lovesTableView.isHidden = true
        self.collectionView.isHidden = false
        collectionViewDataValue = "collection"
        collectionView.reloadData()
    }
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        self.lovesTableView.isHidden = true
        self.collectionView.isHidden = false
        collectionViewDataValue = "posts"
        self.collectionView.reloadData()
        
    }
    
    @IBAction func lovesButtonAction(_ sender: Any) {
        mscrollview.contentSize.height = self.view.frame.size.height
        self.lovesTableView.isHidden = false
        self.collectionView.isHidden = true
        lovesTableView.reloadData()
    }
    
    @IBAction func aboutAction(_ sender: Any) {
        self.parent?.performSegue(withIdentifier: "showAbout", sender: nil)
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        
        self.parent?.performSegue(withIdentifier: "addNewPost", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
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
        if collectionViewDataValue == "posts" {
            var obj = userPostsArray[indexPath.row]
            if indexPath.row == 0 {
                obj = userPostsArray[ section]
            }
            else {
                obj = userPostsArray[1 + section]
            }
            
            URLSession.shared.dataTask(with: URL(string:obj.ImagePath1)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let imageData = data1 {
                        cell.menuImage.image = UIImage(data: imageData)
                    }
                })
                }.resume()
            cell.nameLabel.text = userPostsArray[indexPath.row].dishName
        }
        
       
        else {
            var obj = collectionArray[indexPath.row]
            if indexPath.row == 0 {
                obj = collectionArray[ section]
            }
            else {
                obj = collectionArray[1 + section]
            }
            URLSession.shared.dataTask(with: URL(string:obj["categoryImage"]!)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let imageData = data1 {
                        cell.menuImage.image = UIImage(data: data1!)
                    }
                })
                }.resume()
            cell.nameLabel.text = obj["categoryName"]
        }
        
        
        
        collectionviewheight.constant = collectionView.contentSize.height
        mscrollview.contentSize.height = collectionView.contentSize.height + 300
        

        return cell
        
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
        }
        
        tableviewheight.constant = lovesTableView.contentSize.height
        mscrollview.contentSize.height = lovesTableView.contentSize.height + 300
        collectionviewheight.constant = lovesTableView.contentSize.height
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//       let detailVc =  self.storyboard?.instantiateViewController(withIdentifier: "PostDetailCntrl") as! DetailViewController
//        detailVc.postId = Int(lovesArray[indexPath.row].postId)!
//        self.navigationController?.pushViewController(detailVc, animated: true)
        
        let detailVc =  self.storyboard?.instantiateViewController(withIdentifier: "showpostdetails") as! GetPostDetailsViewController
        detailVc.postId = Int(lovesArray[indexPath.row].postId)!
        print("needed array is = \(lovesArray[indexPath.row])")
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate  {
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: collectionView.bounds.size.width/2-5, height:  180)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "UserPosts", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UserCllectionListCntrl") as!UserCollectionListController
        //detailVc.toc = Int(lovesArray[indexPath.row].postId)!
        self.navigationController?.pushViewController(vc, animated: true)

    }

}

