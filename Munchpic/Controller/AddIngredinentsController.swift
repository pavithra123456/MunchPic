//
//  AddIngredinentsController.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 17/07/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class AddIngredinentsController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var ingredients1: UITextField!
    @IBOutlet weak var ingredients2: UITextField!
    
    @IBOutlet weak var ingredients3: UITextField!
    
    @IBOutlet weak var ingredients4: UITextField!
    
    @IBOutlet weak var ingredients5: UITextField!
    
    @IBOutlet weak var ingredients6: UITextField!
    
    @IBOutlet weak var ingredients7: UITextField!
    
    @IBOutlet weak var ingredients8: UITextField!
    
    @IBOutlet weak var ingredients9: UITextField!
    
    @IBOutlet weak var ingredients110: UITextField!
    
    @IBOutlet weak var ingredients11: UITextField!
    
    @IBOutlet weak var ingredients12: UITextField!
    
    @IBOutlet weak var ingredients13: UITextField!
    
    @IBOutlet weak var ingredients14: UITextField!
    
    @IBOutlet weak var ingredients15: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
