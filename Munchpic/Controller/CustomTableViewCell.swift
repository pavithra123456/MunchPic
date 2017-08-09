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
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var ShowSmilyBtn: UIButton!
    @IBOutlet weak var subHeading: UILabel!
    var lovesStatus = ""
    var postId = 0
    var useId = 0 {
        didSet {
            
        }
    }
    var efforts  = "" {
        didSet {

            if let effortCount =  Int(efforts) {
                if effortCount < 5 {
                    for i in effortCount+1...5 {
                        self.viewWithTag(i)?.backgroundColor = UIColor.lightGray
                    }
                }
                
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

    var longGuesture :UILongPressGestureRecognizer?
    var tapGuesture:UITapGestureRecognizer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let  collectionView = self.collectionView {
            collectionView.dataSource = self
            //collectionView.delegate = self
        }
        if let  _ = self.smilesView {
             longGuesture = UILongPressGestureRecognizer.init(target: self, action: #selector(handleLongPress))
            self.addGestureRecognizer(longGuesture!)
           tapGuesture = UITapGestureRecognizer.init(target: self, action: #selector(handleTap))
            self.addGestureRecognizer(tapGuesture!)
        }
        // Initialization code
    }
    
    func handleLongPress() {
        smilesView.isHidden = false
        tapGuesture?.isEnabled = true
    }
    
    func handleTap() {
        smilesView.isHidden = true
        tapGuesture?.isEnabled = false
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

extension CustomTableViewCell {
    @IBAction func likeBtnAction(_ sender: UIButton) {
       
        
        if self.lovesStatus == "0"  || self.lovesStatus == "" {
            insertLoves( selectedEmoji: 2)
            
            self.likeButton.setImage(UIImage(named:"emoji2"), for: .normal)
        }
            
        else if self.smilesView.isHidden {
            Toast.showToast(text: "please hold for update ", toView: (self.superview?.superview?.superview?.superview!)!)
        }
    }
    
    @IBAction func addloves(_ sender: UIButton) {
        insertLoves( selectedEmoji: sender.tag)
    }
    
    func insertLoves (selectedEmoji:Int) {
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let param = "userId=\(userId)" +
                "&postId=\(self.postId)" +
            "&loveId=\(selectedEmoji)"
            self.smilesView.isHidden = true

            ServiceLayer.insertLoves(parameter: param) { (response, status, msg) in
                print(msg)
                if status && (msg == "Loved" || msg == "Expression updated") {
                    DispatchQueue.main.async(execute: {
                        self.lovesStatus = "\(selectedEmoji)"
                        self.likeButton.setImage(UIImage(named:"emoji\(selectedEmoji)"), for: .normal)
                        Toast.showToast(text: msg, toView: (self.superview?.superview?.superview?.superview!)!)
                    })
                }
            }
        }
    }
}

extension CustomTableViewCell {
    func configureCell (model: PostModel) {
        self.userName.text = model.userName
        self.description1.text = model.descriptionArray[0]
        self.loves.text = "\(model.loves)"
        self.useId = model.userId
        self.efforts  = model.efforts
        self.postId = model.postId
        self.lovesStatus = model.lovesStatus

        if model.lovesStatus != "0" {
            let imageStr = "emoji\(model.lovesStatus)"
            self.likeButton.setImage(UIImage(named:imageStr), for: .normal)
        }
    }
}

