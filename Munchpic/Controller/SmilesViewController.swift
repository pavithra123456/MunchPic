//
//  SmilesViewController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class SmilesViewController: UIViewController {

    var postDetail : PostModel?
    @IBOutlet weak var emoji1count: UILabel!
    
    @IBOutlet weak var emoji2count: UILabel!
    
    @IBOutlet weak var emoji3count: UILabel!
    
    @IBOutlet weak var emoji4count: UILabel!
    
    @IBOutlet weak var emoji5count: UILabel!
    
    @IBOutlet weak var emoj6count: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
        emoji1count.text = postDetail?.love1
        emoji2count.text = postDetail?.love2
        emoji3count.text = postDetail?.love3
        emoji4count.text = postDetail?.love4
        emoji5count.text = postDetail?.love5
        emoj6count.text = postDetail?.love6
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
