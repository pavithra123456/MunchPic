//
//  PostModel.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 24/06/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit

class PostModel: NSObject {
    var postId :Int = 0
    var userName = ""
    var dishName = ""
    var category = ""
    var subCategory = ""
    var cuisine = ""
    
//    var description1 = ""
//    var description2 = ""
//    var description3 = ""
//    var description4 = ""
//    var description5 = ""
//    var description6 = ""
//    var description7 = ""
//    var description8 = ""
//    var description9 = ""
//    var description10 = ""
    
    var descriptionArray = [String]()
    var ingredientsArray = [String]()

    
    var noOfCollection = 0
    var comments = 0
    
    var loves = 0
    var love1 = ""
    var love2 = ""
    var love3	= ""
    var love4	= ""
    var love5	= ""
    var love6	= ""
    var lovesStatus = ""
    
    var ImagePath1 = ""
    var userId = 0
    var efforts = ""
    
    var post1 :UIImage?
    var post2 :UIImage?
    var post3 :UIImage?
    var duration = ""
    var difficulty = ""
    
    
    class func getmodel(postobject:[String:AnyObject]) -> PostModel {
        let model = PostModel()
        model.postId = Int(postobject["postId"] as? String ?? "0")!
        model.userName = postobject["userName"] as? String ?? ""
        model.dishName = postobject["dishName"] as? String ?? ""
        
        
        model.descriptionArray.append(postobject["description1"] as? String ?? "")
        var coloumnKey = "description"
        for i in 1...10 {
            let key = "\(coloumnKey)\(i)"
            if let value =  postobject[key]  as? String{
                if value == "" {
                    continue
                }
                model.descriptionArray.append(value)
            }
        }
        
        coloumnKey = "ingradients"
        for i in 1...16 {
            let key = "\(coloumnKey)\(i)"
            if let value =  postobject[key]  as? String{
                if value == "" {
                    continue
                }
                model.ingredientsArray.append(value)
            }
        }
        
        
        model.ImagePath1 = postobject["ImagePath1"] as? String ?? ""
        if let loveCount =  Int(postobject["loves"] as? String ?? "0") {
            model.loves = loveCount
        }
        
        model.comments = Int(postobject["comments"] as? String ?? "0")!
        model.userId = Int(postobject["userId"] as! String )!
        model.noOfCollection = Int(postobject["collections"] as? String ?? "0")!
        model.comments = Int(postobject["comments"] as? String ?? "0")!
        
        model.efforts = postobject["difficulty"] as? String ?? ""
        model.difficulty = postobject["difficulty"] as? String ?? ""
        
        model.love1 = postobject["love1"] as? String ?? ""
        model.love2 = postobject["love2"] as? String ?? ""
        model.love3 = postobject["love3"] as? String ?? ""
        model.love4 = postobject["love4"] as? String ?? ""
        model.love5 = postobject["love5"] as? String ?? ""
        model.love6 = postobject["love6"] as? String ?? ""
        model.lovesStatus = postobject["lovesStatus"] as? String ?? ""
        return model
    }
}
