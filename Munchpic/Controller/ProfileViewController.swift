//
//  ProfileViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UICollectionViewDataSource{

    @IBOutlet weak var lovesTableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userPostsTableView: UITableView!
    @IBOutlet weak var tableview: UITableView!
    let images = ["food1","food2","food3","food4","img1","img0","img2","food5"]
    @IBOutlet var headerView: UIView!
    var collectionArray = [[String:String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
       collectionView.dataSource = self
//        self.collectionview.register( UINib(nibName: "ProfileHeaderView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "profileHeader")
//        self.collectionview.reloadData()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.getCollectioncategories()
        getLoves()
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
        ServiceLayer.getLoves { (response, status, msg) in
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  collectionArray.count/2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for:indexPath) as! CustomCollectionViewCell
        let obj = collectionArray[indexPath.row]
        
        URLSession.shared.dataTask(with: URL(string:obj["categoryImage"]!)!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {

                cell.menuImage.image = UIImage(data: data1!)
            })
            }.resume()
        cell.nameLabel.text = obj["categoryName"]

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

extension ProfileViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: "cell")!
        
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate  {
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width/2, height: 200)
    }
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionElementKindSectionHeader {
//            
//              let headerView = collectionview.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "profileHeader", for: indexPath)
//
//           
//            return headerView
//        }
//        return UICollectionReusableView()
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//       return  CGSize(width: 100, height: 220)
//    }
    

}

