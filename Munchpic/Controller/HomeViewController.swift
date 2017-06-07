//
//  HomeViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var Pagingimage: UIImageView!
    @IBOutlet var pagecontroller: UIPageControl!
    @IBOutlet var mscrollview: UIScrollView!
    @IBOutlet var Hometableview: UITableView!
    let images = ["img0","img1","img2","","","",""]
    
    
    var slidearrayData:NSMutableArray = NSMutableArray()
    var mPosition:Int = Int()
    var myint = Int()
    var index = 0
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    var slidetimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        slidearrayData = ["1.png","2.png","3.png","1.png","2.png","3.png","1.png","2.png"]
        
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        self.swipeGestureLeft.addTarget(self, action:#selector(HomeViewController.handleSwipeLeft(gesture:)))
        self.swipeGestureRight.addTarget(self, action:#selector(HomeViewController.handleSwipeRight(gesture:)))
        mscrollview.addGestureRecognizer(self.swipeGestureLeft)
        mscrollview.addGestureRecognizer(self.swipeGestureRight)
        
        slidetimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector:#selector(HomeViewController.handleSwipeLeft(gesture:)), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func Pagecontroller_Action(_ sender: Any) {
        
        let servicesList1: (AnyObject) = (slidearrayData[(pagecontroller.currentPage)] as AnyObject)
        Pagingimage.image = UIImage(named: servicesList1 as! String)
        mPosition = pagecontroller.currentPage
        
    }
    
    //Left gesture
    func handleSwipeLeft(gesture: UISwipeGestureRecognizer){
        
        if pagecontroller.currentPage < slidearrayData.count-1 {
            pagecontroller.currentPage += 1
            let servicesList1: (AnyObject) = (slidearrayData[(pagecontroller.currentPage)] as AnyObject)
            Pagingimage.image = UIImage(named: servicesList1 as! String)
            mPosition = pagecontroller.currentPage
        }else{
            pagecontroller.currentPage = 0
            let servicesList1: (AnyObject) = (slidearrayData[(pagecontroller.currentPage)] as AnyObject)
            Pagingimage.image = UIImage(named: servicesList1 as! String)
            mPosition = pagecontroller.currentPage
            
        }
    }
    
    // Right gesture
    func handleSwipeRight(gesture: UISwipeGestureRecognizer){
        
        if pagecontroller.currentPage != 0 {
            pagecontroller.currentPage -= 1
            let servicesList1: (AnyObject) = (slidearrayData[(pagecontroller.currentPage)] as AnyObject)
            Pagingimage.image = UIImage(named: servicesList1 as! String)
            mPosition = pagecontroller.currentPage
            
        }else{
            
            pagecontroller.currentPage = slidearrayData.count
            let servicesList1: (AnyObject) = (slidearrayData[(pagecontroller.currentPage)] as AnyObject)
            Pagingimage.image = UIImage(named: servicesList1 as! String)
            mPosition = pagecontroller.currentPage
            
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : CustomTableViewCell! = Hometableview.dequeueReusableCell(withIdentifier: "Hcell") as! CustomTableViewCell
        if(cell == nil)
        {
            cell = Bundle.main.loadNibNamed("Hcell", owner: self, options: nil)?[0] as! CustomTableViewCell;
        }
        
        let servicesList1: (AnyObject) = (slidearrayData[indexPath.row] as AnyObject)
        cell.foodrecipeImage.image = UIImage(named: images[indexPath.row] as! String)
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    override func viewDidAppear(_ animated: Bool) {
        ServiceLayer.requestManager.GetCollections(parameter: nil) { (array, status, message) in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


