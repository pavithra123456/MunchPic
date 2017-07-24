//
//  WindowViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import  MBProgressHUD


class WindowViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var exploreBythemeLabel: UILabel!
    @IBOutlet var mscrollview: UIScrollView!
    @IBOutlet var menucollectionview: UICollectionView!
    @IBOutlet var menutableview: UITableView!
    @IBOutlet var heightconstraint: NSLayoutConstraint!
    var trendsArray = [TrendsModel]()
    var cornibvalsArray = [[String:String]]()
    let imageNameArray = ["food1","food2","food3","food4","img0"]
    
    
    @IBOutlet weak var exploreByThemeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appdelegate =  (UIApplication.shared.delegate as! AppDelegate)
        if appdelegate .isForWindowDetailView == false {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            ServiceLayer.getCornivals { (response, status, message) in
                MBProgressHUD.hide(for: self.view, animated: true)
                
                if status == true {
                    
                    let response1 = response as! [String:AnyObject]
                    if let array = response1["result"] as? Array<AnyObject> {
                        for obj in array {
                            let trendObject = obj
                            let str =  trendObject["cornivalsName"] as! String
                            let imgString =  trendObject["cornivalsImageUrl"] as! String
                            let dict = ["labelName":str,"imageName":imgString]
                            self.cornibvalsArray.append(dict)
                        }
                    }
                    self.menucollectionview.reloadData()
                }
            }
        }
            
        else {
            exploreByThemeView.frame =  CGRect(x: exploreByThemeView.frame.origin.x, y: exploreByThemeView.frame.origin.y, width: exploreByThemeView.frame.width, height: 40)// .width = 10
            self.menucollectionview.isHidden = true
            self.exploreBythemeLabel.isHidden = true
        }

        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        ServiceLayer.getTrends { (response, status, errorMessage) in
            if status == true {
                
                let response1 = response as! [String:AnyObject]
                if let array = response1["result"] as? Array<AnyObject> {
                    self.trendsArray.removeAll()
                    for obj in array {
                        let trendObject = obj
                        
                         let trendModel = TrendsModel()
                          trendModel.heading = trendObject["trendsHeading"] as! String
                          trendModel.sSubHeading = trendObject["trendsSubHeading"] as! String
                           trendModel.mainImage = trendObject["trendsMainImage"] as! String
                        
                        if let img1 = trendObject["trendsImageUrl1"] {
                            
 
                            trendModel.imagesArray.append(img1 as! String)
                        }
                        if let img1 = trendObject["trendsImageUrl2"] {
                            trendModel.imagesArray.append(img1 as! String)
                        }
                        if let img1 = trendObject["trendsImageUrl3"] {
                            trendModel.imagesArray.append(img1 as! String)
                        }
                        if let img1 = trendObject["trendsImageUrl4"] {
                            trendModel.imagesArray.append(img1 as! String)
                        }
                        if let img1 = trendObject["trendsImageUrl5"] {
                            trendModel.imagesArray.append(img1 as! String)
                        }
                        if let img1 = trendObject["trendsImageUrl6"] {
                            trendModel.imagesArray.append(img1 as! String)
                        }
                           self.trendsArray.append(trendModel)
                    }
                }
                
                DispatchQueue.main.async(execute: {
                    self.menutableview.reloadData()

                })
                
            }
        }
        
        menutableview.contentSize = CGSize(width: menutableview.contentSize.width, height: menutableview.contentSize.height + 500)
    }
    
    override func viewDidLayoutSubviews() {
        //mscrollview.isScrollEnabled = true
       // mscrollview.contentSize = CGSize(width: self.view.frame.size.width, height: menutableview.contentSize.height+200)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cornibvalsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = menucollectionview.dequeueReusableCell(withReuseIdentifier: "HCell", for:indexPath) as! CustomCollectionViewCell
        
        //let servicesList1: (AnyObject) = (imagedata[indexPath.item])
        
               
       // mscrollview.contentSize = CGSize(width: self.view.frame.size.width, height: menutableview.contentSize.height+200)
        //menutableview.frame.size.height = menutableview.contentSize.height
       // heightconstraint.constant = menutableview.frame.size.height
        let dict = cornibvalsArray[indexPath.row]
        
        URLSession.shared.dataTask(with: URL(string:dict["imageName"]!)!) { (data1, response, error) in
            if data1 != nil {
       DispatchQueue.main.async(execute: {
                
                cell.menuImage.image = UIImage(data: data1!)
       }) }
            }.resume()
        cell.nameLabel.text = dict["labelName"]
        cell.layoutIfNeeded()
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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

extension WindowViewController : UITableViewDelegate { }

extension WindowViewController : UITableViewDataSource {
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return categories[section]
    //    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        URLSession.shared.dataTask(with: URL(string:trendsArray[indexPath.row].mainImage)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                if let data =  data1 {
                    cell.foodrecipeImage.image = UIImage(data: data1!)
                }
                cell.layoutIfNeeded()

            })
            }.resume()
        cell.userName.text = trendsArray[indexPath.row].heading
        cell.subHeading.text = trendsArray[indexPath.row].sSubHeading
        cell.imageNameArray = trendsArray[indexPath.row].imagesArray
        cell.layoutIfNeeded()
        return cell
    }
    
}
