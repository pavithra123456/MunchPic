//
//  UserCollectionListController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 24/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import MBProgressHUD
class UserCollectionListController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    var  toCategory = "Deserrts"
    var collectionArray = [ProfilkeLovesModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getCollecions()
        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - TableView Delegate
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let loveCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LovesTableViewCell
        
        loveCell.postName.text = collectionArray[indexPath.row].dishName
        loveCell.creationDateLabel.text = collectionArray[indexPath.row].dateSaved
        
        let imgrl =  "http://www.ekalavyatech.com/munchpic.com/munchpicPHP/upload/\(collectionArray[indexPath.row].postedUserId)/\(collectionArray[indexPath.row].postId)_post1.jpg"
        URLSession.shared.dataTask(with: URL(string:imgrl)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                if let data =  data1 {
                    loveCell.postImage.image = UIImage(data: data)
                }
            })
            }.resume()
        
        return loveCell
    }
    
    func getCollecions () {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let prameter = "userId=\(userId) +&toCategory=\(toCategory)"
            ServiceLayer.getCollections(parameter: prameter , completion: { (collectionlist, true,msg) in
                self.collectionArray = collectionlist!
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
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
