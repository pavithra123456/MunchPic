//
//  UserPostsController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 07/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class UserPostsController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var userpic: UIImageView!

    var selectedUSerID = 0
    var selectedPostId = 0
    
    @IBOutlet weak var userName: UILabel!
    var userPostsArray = [PostModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        getUserPosts()
            let imgrl = "http://ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(String(describing: selectedUSerID))/user.jpg"
            URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
                DispatchQueue.main.async(execute: {
                    if let data =  data1 {
                        self.userpic.image = UIImage(data: data)
                        self.userpic.layer.cornerRadius = self.userpic.frame.size.width/2
                         self.userpic.layer.masksToBounds = true
                        self.userpic.superview?.layer.cornerRadius =  (self.userpic.superview?.frame.size.width)!/2
                        self.userpic.superview?.layer.masksToBounds = true

                    }
                })
                }.resume()
            
        

        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func getUserPosts () {
        ServiceLayer.getUserPosts(relativeUrl: "userId=\(selectedUSerID)") { (response, status, msg) in
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
                self.tableview.reloadData()
               self.navigationItem.title = self.userPostsArray[0].userName

            }
            
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPostsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostCell
        cell.foodName.text = userPostsArray[indexPath.row].dishName
        URLSession.shared.dataTask(with: URL(string:userPostsArray[indexPath.row].ImagePath1)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                if let data =  data1 {
                    cell.foodImage.image = UIImage(data: data)
                }
            })
            }.resume()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPostId = userPostsArray[indexPath.row].postId
        self.performSegue(withIdentifier: "showDetailOfUserPost", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        UserDefaults.standard.set(false, forKey: "editvisible")
        let detaILVC = segue.destination as! DetailViewController
        detaILVC.postId = selectedPostId
    }
 

}
