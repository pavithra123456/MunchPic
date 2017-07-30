//
//  SplashScreenController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 29/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class SplashScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
let webview = UIWebView(frame: self.view.frame)
        webview.loadHTMLString("index.html", baseURL: URL(string: "file:///Users/pjayanna/Documents/Pavithra/MunchPicProject/images_folderwise/shutter%20effect%20web%20view/index.html"))
        self.view.addSubview(webview)
        
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
