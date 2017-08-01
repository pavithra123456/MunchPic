//
//  SearchViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

enum SubCategory : String{
    case Breakfast
    case Lunch
    case Dinner
    case Desserts
}

enum Cuisine : String{
    case NorthIndia = "North India"
    case Rajasthani
    case Gujarathi
    case Chinese
    case SouthIndia = "South India"
    case NorthEastIndia = "North East India"
}

class SearchViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    var category = "veg"
    
  private let cuisineArray = [Cuisine.NorthIndia,Cuisine.Rajasthani,Cuisine.Gujarathi,Cuisine.Chinese,Cuisine.SouthIndia,Cuisine.NorthEastIndia]
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchbar: UISearchBar!

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
        return cuisineArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "serachCell", for:indexPath) as! CustomCollectionViewCell
        
        let trimmedString = cuisineArray[indexPath.row].rawValue.replacingOccurrences(of: " ", with: "")
        print(trimmedString)

        cell.menuImage.image = UIImage(named:trimmedString)
        cell.nameLabel.text = cuisineArray[indexPath.row].rawValue
        
        return cell
        
    }

//    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionElementKindSectionHeader {
//            
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "searchHeader", for: indexPath)
//            
//            
//            return headerView
//        }
//        
//        return UICollectionReusableView()
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return  CGSize(width: 100, height: 120)
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "UserPosts", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SearchFilterCtrl") as!SearchFilterListController
        vc.category = category
        vc.cuisine = cuisineArray[indexPath.row].rawValue
        vc.subCategory = ""
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func showFilterList(_ sender: UIButton) {
        self.searchbar.resignFirstResponder()
        var subCategory:SubCategory?

        switch sender.tag {
        case 1:
            subCategory =  SubCategory.Breakfast
        case 2:
            subCategory =  SubCategory.Lunch
        case 3:
            subCategory =  SubCategory.Dinner
        case 3:             subCategory =  SubCategory.Desserts

        default:
            break
            
        }
        
        
        let storyBoard = UIStoryboard(name: "UserPosts", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SearchFilterCtrl") as!SearchFilterListController
        vc.category = category
        vc.cuisine = ""
        vc.searchBar = searchbar.text!
        if let value = (subCategory?.rawValue) {
            vc.subCategory = value
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func vegBtnAction(_ sender: UIButton) {
        if category == "veg" {
            category = "Non-Veg"
            sender.setImage(UIImage(named:"nonveg"), for: .normal)
            
        }
        else {
            sender.setImage(UIImage(named:"veg"), for: .normal)
            category = "veg"
        }
        
    }
}
