//
//  CustomTableViewCell.swift
//  MPHome
//
//  Created by ypomacmini on 06/06/17.
//  Copyright © 2017 YourPracticeOnline. All rights reserved.
//

import UIKit
import Foundation

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var emojiImage: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    //home
    @IBOutlet var foodrecipeImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var effortView1: UIView!
    @IBOutlet weak var effortView2: UIView!
    @IBOutlet weak var effortView3: UIView!
    @IBOutlet weak var effortView4: UIView!
    @IBOutlet weak var effortView5: UIView!
    
    @IBOutlet weak var smilesView: UIView!
    
    @IBOutlet weak var subHeading: UILabel!
    var useId = 0 {
        didSet {
            
        }
    }
    var efforts  = "" {
        didSet {
            print(efforts)
            let start = efforts.index(efforts.startIndex, offsetBy:0)
            let end = efforts.index(efforts.endIndex, offsetBy: -4)
            let range = start..<end
            let actualEffort = Int(efforts.substring(with: range))
            print(actualEffort)

            if  actualEffort != nil {
                let effortCount =  actualEffort!/12
                
                if effortCount < 5 {
                    for i in effortCount+1...5 {
                        self.viewWithTag(i)?.backgroundColor = UIColor.lightGray
                    }
                }
                
                
//                if effortCount == 1 {
//                    let labelColor = UIColor(hexColor: 0x336141)
//                    
//                    effortView1.backgroundColor = labelColor
//                    
//                    
//                }
//                else if effortCount == 2 {
//                    let labelColor = UIColor(hexColor: 0x008000)
//                    
//                    effortView2.backgroundColor = labelColor
//                }
//                else if effortCount == 3 {
//                    let labelColor = UIColor(hexColor: 0xF44336)
//                    
//                    effortView3.backgroundColor = labelColor
//                }
//                else if effortCount == 4 {
//                    let labelColor = UIColor(hexColor: 0xCC543C)
//                    
//                    effortView4.backgroundColor = labelColor
//                }
//                else if effortCount == 5 {
//                    let labelColor = UIColor(hexColor: 0xCC543C)
//                    
//                    effortView5.backgroundColor = labelColor
//                }

            }
            
            
        }
    }
    
    var imageNameArray = [String] (){
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionCount: UILabel!
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

    @IBOutlet weak var commentBtn: UIButton!
    
}


extension CustomTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Rcell", for: indexPath) as! CustomCollectionViewCell
        
        URLSession.shared.dataTask(with: URL(string:imageNameArray[indexPath.row] )!) { (data1, response, error) in
            DispatchQueue.main.async(execute: {
                if let imgdata = data1 {
                    cell.menuImage.image = UIImage(data: imgdata)
                }
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

