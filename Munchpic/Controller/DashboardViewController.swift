//
//  DashboardViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 07/06/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var windowBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    
    @IBOutlet weak var homeContainer: UIView!
    @IBOutlet weak var windowContainer: UIView!
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var profileContainer: UIView!

    var homeBorder: UIView?
    var windowBorder: UIView?
    var searchBorder: UIView?
    var profileBorder: UIView?

    var gifimageview = UIImageView()
    var boolforgif = Bool()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boolforgif = UserDefaults.standard.bool(forKey: "afterlogin")
        
        if(boolforgif == true){
            
            gifimageview.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: self.view.frame.size.height)
            UIApplication.shared.keyWindow?.addSubview(gifimageview)
            gifimageview.image = UIImage.gif(name: "Shutter")
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gifDidStop(sender:)), userInfo: nil, repeats: false)
            
        }else{
            
             UserDefaults.standard.set(false, forKey: "afterlogin")

        }
        
               homeBorder = homeBtn.addBorder(borderPostion: .bottom)

        // Do any additional setup after loading the view.
    }

    
    func gifDidStop(sender: UIImageView) {
        print("gifDidStop")
        gifimageview.isHidden = true
        
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @IBAction func profileBtnAction(_ sender: Any) {
        homeBtn.tintColor = UIColor.yellow
        profileBorder = profileBtn.addBorder(borderPostion: .bottom)

        profileContainer.isHidden = false
        profileBorder?.isHidden = false
        
        homeContainer.isHidden = true
        homeBorder?.isHidden = true
        
        windowContainer.isHidden = true
        windowBorder?.isHidden = true
        
        searchContainer.isHidden = true
        searchBorder?.isHidden = true
        self.navigationItem.title = "UserPosts"
    }

    @IBAction func serachBtnAction(_ sender: Any) {
        searchBorder = searchBtn.addBorder(borderPostion: .bottom)

        searchContainer.isHidden = false
        searchBorder?.isHidden = false
        
        homeContainer.isHidden = true
        homeBorder?.isHidden = true
        
        windowContainer.isHidden = true
        windowBorder?.isHidden = true
        
        profileContainer.isHidden = true
        profileBorder?.isHidden = true
        self.navigationItem.title = "Search"

        
    }
    
    @IBAction func windowBtnAction(_ sender: Any) {
        windowBorder = windowBtn.addBorder(borderPostion: .bottom)

        windowContainer.isHidden = false
        windowBorder?.isHidden = false
        
        homeContainer.isHidden = true
        homeBorder?.isHidden = true
        
        searchContainer.isHidden = true
        searchBorder?.isHidden = true
        
        profileContainer.isHidden = true
        profileBorder?.isHidden = true
        self.navigationItem.title = "Comapaigns"

    }
    
    @IBAction func homeBtnAction(_ sender: Any) {
        homeBorder = homeBtn.addBorder(borderPostion: .bottom)

        homeBorder?.isHidden = false
        homeContainer.isHidden = false
        
        windowContainer.isHidden = true
        windowBorder?.isHidden = true
        
        searchContainer.isHidden = true
        searchBorder?.isHidden = true
        
        profileContainer.isHidden = true
        profileBorder?.isHidden = true
        self.navigationItem.title = "Home"

        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            let detaILVC = segue.destination as! DetailViewController
//            detaILVC.postId = selectedPostId
//            selectedPostId = 0
//        }
//    }

}

extension UIView {
    enum  BorderPosition {
        case left
        case right
        case top
        case bottom
    }
    
    /// Add borders to UIView based on position.
    func addBorder(borderPostion: BorderPosition, borderColor: UIColor = UIColor.yellow, borderWidth: CGFloat = 1.3) -> UIView {
        
        let borderName = "bottomBorder"
        
        if let sublayers = self.layer.sublayers {
            let bottomLayer = sublayers.filter({$0.name == borderName})
            bottomLayer.forEach({$0.removeFromSuperlayer()})
        }
        
        let bottomLayer = self.subviews.filter({$0.tag == 1})
        
        bottomLayer.forEach({$0.removeFromSuperview()})
        
        let border = UIView()
        border.backgroundColor = borderColor
        //        border.masksToBounds = true
        //        border.name = borderName
        
        switch borderPostion {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: borderWidth)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.bounds.size.height - borderWidth, width: self.bounds.size.width, height: borderWidth)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: self.bounds.size.height)
        case .right:
            border.frame = CGRect(x: self.bounds.size.width - borderWidth, y: 0, width: borderWidth, height: self.bounds.size.height)
        }
        
        border.tag = 1
        self.addSubview(border)
        return border
    }
    
    func removeBorder(borderName: String = "bottomBorder") {
        if let sublayers = self.layer.sublayers {
            let bottomLayer = sublayers.filter({$0.name == borderName})
            bottomLayer.forEach({$0.removeFromSuperlayer()})
        }
    }
}
