//
//  CustomTableViewCell.swift
//  MPHome
//
//  Created by ypomacmini on 06/06/17.
//  Copyright © 2017 YourPracticeOnline. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    //home
    @IBOutlet var foodrecipeImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var subHeading: UILabel!
    var useId = 0 {
        didSet {
            self.getYUserDetails()
        }
    }
    
    var imageNameArray = [String] (){
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var description1: UILabel!

    @IBOutlet weak var loves: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        if let  collectionView = self.collectionView {
            collectionView.dataSource = self
            //collectionView.delegate = self
        }
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension CustomTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Rcell", for: indexPath) as! CustomCollectionViewCell
        
        URLSession.shared.dataTask(with: URL(string:imageNameArray[indexPath.row] )!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                cell.menuImage.image = UIImage(data: data1!)
            })
            }.resume()
        let str = imageNameArray[indexPath.row]  
        let start = str.index(str.startIndex, offsetBy: 73)
        let end = str.index(str.endIndex, offsetBy: -4)
        let range = start..<end
        cell.nameLabel.text = str.substring(with: range)

        return cell
    }
}

//extension CustomTableViewCell : UICollectionViewDelegateFlowLayout,UICollectionViewDelegate  {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemsPerRow:CGFloat = 4
//        let hardCodedPadding:CGFloat = 5
//        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
//        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
//        self.collectionView.contentSize = CGSize(width: collectionView.contentSize.width+200, height: collectionView.contentSize.height)
//        return CGSize(width: itemWidth, height: itemHeight)
//    }
//}

extension CustomTableViewCell {
    func getYUserDetails() {
        let url = Constants.kBaseUrl + Constants.KGetUserInfo + "userId=\(self.useId)"
        ServiceLayer.getusetInfo(relativeUrl: url) { (data, status, message) in
            if data != nil {
                self.profilePic.image = UIImage(data: data as! Data)
            }
        }
    }
}

