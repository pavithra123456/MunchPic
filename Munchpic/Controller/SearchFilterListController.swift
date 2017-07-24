//
//  SearchFilterListController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 07/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class SearchFilterListController: UIViewController ,UITableViewDataSource{

    var cuisine = ""
    var category = ""
    var subCategory = ""
    var searchBar = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filter()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell")
        return cell!
    }
    
    @IBAction func backAction(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
    }
    
    func filter() {
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let param = "userId=\(userId)" +
                "&searchBar=\(searchBar)" +
            "&category=\(category)"
                +
                "&subCategory=\(subCategory)" +
            "&cuisine=\(cuisine)"
            
            ServiceLayer.filter(param: param, completion: { (reponse, status, msg) in
                print(msg,reponse)
                
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
