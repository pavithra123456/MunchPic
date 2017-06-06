//
//  WindowViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class WindowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView:UIView =  UIView()
        let imageViewGame = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100));
        let image = UIImage(named: "3.png");
        imageViewGame.image = image;
        headerView.addSubview(imageViewGame)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 100
    }
    
    
    
}
