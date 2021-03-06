//
//  SearchFilterListController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 07/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import MBProgressHUD

class SearchFilterListController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tableview: UITableView!
    var cuisine = ""
    var category = ""
    var subCategory = ""
    var searchBar = ""
    
    @IBOutlet weak var navigationTitleLabel: UILabel!
    var fileteredArray = [PostModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var categoryStr = "Veg"
        if category != "veg" {
            categoryStr = "Non-Veg"
        }
        if subCategory != "" {
            self.navigationItem.title = "\(categoryStr)/\(subCategory)"
        }
        else if searchBar != "" {
            self.navigationItem.title = "\(categoryStr)/\(searchBar)"
        }

         else if cuisine != "" {
            
             self.navigationItem.title = "\(categoryStr)/\(cuisine)"
        }
        else {
            self.navigationItem.title = "Searching"
        }
        
        filter()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchFileterCell
        cell.lovesCountLAbel.text = "\(fileteredArray[indexPath.row].loves)"
        
        cell.dishName .text = fileteredArray[indexPath.row].dishName
        cell.cuisineLAbel.text = fileteredArray[indexPath.row].cuisine
        if fileteredArray[indexPath.row].category != "Veg" {
            cell.categoryImage.image = UIImage(named: "nonveg")
        }
        URLSession.shared.dataTask(with: URL(string:fileteredArray[indexPath.row].ImagePath1)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                if let data =  data1 {
                    cell.postImage.image = UIImage(data: data)
                                    }
            })
            }.resume()

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboad = UIStoryboard(name: "Main", bundle: Bundle.main)
              let detailVc = storyboad.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
       // detailVc.postDetails = fileteredArray[indexPath.row]
        detailVc.postId = fileteredArray[indexPath.row].postId
        detailVc.isDetaiLForLovedPost = true
        UserDefaults.standard.set(false, forKey: "editvisible")
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        let _ =  self.navigationController?.popViewController(animated: true)
    }
    
    func filter() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let param = "userId=\(userId)" +
                "&searchBar=\(searchBar)" +
            "&category=\(category)"
                +
                "&subCategory=\(subCategory)" +
            "&cuisine=\(cuisine)"
            
            ServiceLayer.filter(param: param, completion: { (reponseArray, status, msg) in
//                print(msg,reponseArray)
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    if status == false {
                        Toast.showToast(text: "No result found", toView: self.view)
                        return
                    }
                    for postobject in reponseArray! {
                        
                        let model =  PostModel.getmodel(postobject: postobject)
                        let imgrl =  "http://www.ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(model.userId)/\(model.postId)_post1.jpg"
                        model.ImagePath1 = imgrl
                        self.fileteredArray.append(model)
                        
                    }
                }
                
                
                DispatchQueue.main.async {
                    if self.fileteredArray.count == 0 {
                        Toast.showToast(text: "No result found", toView: self.view)
                        self.tableview.isHidden = true
                    }
                    self.tableview.reloadData()
                }

            })
            
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

}
