//
//  SearchViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.collectionView.delegate = self
//        self.collectionView.register( UINib(nibName: "SearchHeaderView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "searchHeader")
//        self.collectionView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        scrollview.contentSize = CGSize(width: scrollview.contentSize.width, height: scrollview.contentSize.height+30)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for:indexPath) as! CustomCollectionViewCell
        //cell.menuImage.image = UIImage(named: images[indexPath.row])
        
        return cell
        
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "searchHeader", for: indexPath)
            
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return  CGSize(width: 100, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchFilterCtrl")
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func showFilterList(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "UserPosts", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SearchFilterCtrl") as!SearchFilterListController
        vc.category = "veg"
        vc.cuisine = "Rajsthani"
        vc.subCategory = "Lunch"
        
        self.navigationController?.present(vc, animated: true, completion: nil)
        //pushViewController(vc, animated: true)

    }

}
