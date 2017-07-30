//
//  ServiceLayer.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
///Users/ypo/Desktop/Chaitanya/Munchpic/Munchpic.xcodeproj

import UIKit
import Alamofire
import Foundation

class ServiceLayer: NSObject {
    static let requestManager = ServiceLayer()
    private override init() {
        
    }
    
    class func login(relativeUrl :String,completion:@escaping (AnyObject?,Bool,String) ->Void){
        
        
        ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.KLogin, postbody: relativeUrl) { (response, status, msg) in
            if status == true {
                completion(response as? [[String : AnyObject]] as AnyObject , true, "Success")
            }
            else {
                completion(nil , false, msg)

            }
        }

        
    }

    class func getPosts(completion:@escaping ([PostModel]?,Bool,String)->Void){
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let parameter = "userId=\(userId)"

            ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.kGetPost, postbody: parameter) { (response, status, msg) in
                if status {
                    let response1 = response as! [[String:AnyObject]]
                    var postArray = [PostModel]()
                    
                    for postobject in response1 {
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
                        
                        postArray.append(model)
                    }
                    completion(postArray, true, "Success")
                    
                }
                else {
                    completion(nil, false, "fail")

                }
                
            }
        }
    }
    
    class func getCollections(parameter:String,completion:@escaping ([ProfilkeLovesModel]?,Bool,String)->Void){
        
        ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.kGetCollections, postbody: parameter) { (response, status, msg) in
            if status {
                let response1 = response as! [[String:AnyObject]]
                    var collectionArray = [ProfilkeLovesModel]()
                    
                    for obj in response1 {
                        let lovemOdel = ProfilkeLovesModel()
                        lovemOdel.dishName = obj["dishName"] as! String
                        lovemOdel.dateSaved = obj["dateSaved"] as! String
                        lovemOdel.postId = obj["collectionPostId"] as! String
                        lovemOdel.postedUserId =  obj["postedUserId"] as! String
                        
                        lovemOdel.imageName = ""
                        collectionArray.append(lovemOdel )
                    }
                    completion(collectionArray , true, "Success")
                
            }

        }
    }
    
    class func GetIngredients(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetIngredients, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }

    class func GetComments(forPostId:Int,completion:@escaping ([[String:AnyObject]]?,Bool,String)->Void){
      
       
        ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.kGetComments, postbody: "postId=\(forPostId)") { (response, status, msg) in
            if status == true {
                completion(response as? [[String : AnyObject]] , true, "Success")

            }
            else {
                
            }
        }
        
    }
    
    class func getPostDetails(forPostId:Int,completion:@escaping ([[String:AnyObject]]?,Bool,String)->Void){
        
        
        ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.kGetParticularPost, postbody: "postId=\(forPostId)") { (response, status, msg) in
            if status == true {
                completion(response as? [[String : AnyObject]] , true, "Success")
                
            }
            else {
                
            }
        }
        
    }
    
    class func filter(param:String,completion:@escaping ([[String:AnyObject]]?,Bool,String)->Void){
        
        
        
        ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.KFilter, postbody: param) { (response, status, msg) in
            if status == true {
                completion(response as? [[String : AnyObject]]  , true, "Success")
            }
            else {
                completion(nil , false, msg)
                
            }
        }
    }
    
    
    
    class func getCornivals(completion:@escaping (AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetCornivals, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                completion(response.result.value as AnyObject, true, "")
            }
        }
    }
    class func getCollectionCategories(completion:@escaping (AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetCollectionCategories, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                let response1 =  response.result.value as! [String:AnyObject]
                if let array = response1["result"] as? Array<AnyObject> {
                    var collectionArray = [[String:String]]()

                    for obj in array {
                        collectionArray.append(obj as! [String : String])
                    }
                    completion(collectionArray as AnyObject, true, "Success")
                }
                
            }
        }
    }
    
    
    class func getLoves(completion:@escaping ([ProfilkeLovesModel]?,Bool,String)->Void) {
        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            let parameter = "userId=\(userId)"
            ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.kGetLoves, postbody: parameter) { (response, status, msg) in
                if status == true {
                    var collectionArray = [ProfilkeLovesModel]()
                    let responseArray = response as! Array<AnyObject>
                    for obj in responseArray {
                        let lovemOdel = ProfilkeLovesModel()
                        lovemOdel.dishName = obj["dishName"] as! String
                        lovemOdel.dateSaved = obj["dateSaved"] as! String
                        lovemOdel.postId = obj["lovesPostId"] as! String
                        lovemOdel.postedUserId =  obj["postedUserId"] as! String
                        
                        
                        lovemOdel.imageName = ""
                        collectionArray.append(lovemOdel)
                    }
                    completion(collectionArray, true, "Success")
                }
                else {
                    
                }
            }
        }
        
       
        
//        Alamofire.request(Constants.kBaseUrl + Constants.kGetLoves, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            
//            if response.result.isSuccess {
//                let response1 =  response.result.value as! [String:AnyObject]
//                if let array = response1["result"] as? Array<AnyObject> {
//                    var collectionArray = [ProfilkeLovesModel]()
//                    
//                    for obj in array {
//                        let lovemOdel = ProfilkeLovesModel()
//                        lovemOdel.dishName = obj["dishName"] as! String
//                        lovemOdel.dateSaved = obj["dateSaved"] as! String
//                        
//                        lovemOdel.imageName = ""
//                        collectionArray.append(lovemOdel)
//                    }
//                                            completion(collectionArray, true, "Success")
//
//                }
//            
//            }
//        }
    }
       
    class func getTrends(completion:@escaping (AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetTrends, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                completion(response.result.value as  AnyObject,true,"Success")
            }
        }
    }

    class  func getUserPosts(relativeUrl:String,completion:@escaping ([[String : AnyObject]]?,Bool,String)->Void){
    
    ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.kGetUserPosts, postbody: relativeUrl) { (response, status, msg) in
        if status == true {
            completion(response as? [[String : AnyObject]]   , true, "Success")
        }
        else {
            
            
        }
    }
    }
       class func insertPost(parameter:String,completion:@escaping (AnyObject?,Bool,String)->Void){
            
            
            ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.kInsertPost, postbody: parameter) { (response, status, msg) in
                if status == true {
                    completion(response as? [[String : AnyObject]] as AnyObject , true, "Success")
                }
                else {
                    completion(nil , false, msg)
                    
                }
            }

            
        }
        
    
    class func insertLoves(parameter:String,completion:@escaping (AnyObject?,Bool,String)->Void){
        
        ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.kInsertLoves, postbody: parameter) { (response, status, msg) in
            if status == true {
                completion(response as? [[String : AnyObject]] as AnyObject , true, "Success")
            }
            else if msg == "Loved" || msg == "Expression updated" {
                completion(nil , true, msg)
            }
            else {
                completion(nil , false, msg)

            }
        }
        
    }
    
    class func insertCollections(parameter:String,completion:@escaping (AnyObject?,Bool,String)->Void){
        
        ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.kInsertCollections, postbody: parameter) { (response, status, msg) in
            if status == true {
                completion(response as? [[String : AnyObject]] as AnyObject , true, "Success")
            }
            else {
                completion(nil , false, msg)
            }
        }
    }
    
   class  func insertComments(parameter:String,completion:@escaping (AnyObject?,Bool,String)->Void){
    
//        Alamofire.request(Constants.kBaseUrl + Constants.kInsertComments, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            
//            if response.result.isSuccess {
//            }
//        }
    
    ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.kInsertComments, postbody: parameter) { (response, status, msg) in
        if status == true {
            completion(response as? [[String : AnyObject]] as AnyObject , true, "Success")
        }
        else if msg == "Commented"{
            completion(nil , true, msg)
            
        }
        else {
            completion(nil , true, msg)

        }
    }

    
    
    }
  
    class func deleteCollection(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kDeleteCollection, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }

    class func getusetInfo(forUserID:String,completion:@escaping ([[String:AnyObject]]?,Bool,String)->Void){
        
        
        ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.KGetUserInfo, postbody: "userId=\(forUserID)") { (response, status, msg) in
            if status == true {
                completion(response as? [[String : AnyObject]] , true, "Success")
                
            }
            else {
                
            }
        }

    
    }
    
    
    
    class func excuteQuery(url:String,postbody:String,completion:@escaping (AnyObject?,Bool,String)->Void) {
        
        let url = URL(string: url)
        var req =  URLRequest(url: url!)
        req.httpMethod = "POST"
        req.httpBody = postbody.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: req) { (data, resposne, error) in
            print(Data())
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                completion(nil, false, (error?.localizedDescription)!)

                return
            }
            
            if let httpStatus = resposne as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                completion(nil, false, (error?.localizedDescription)!)

            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            do {
                let repsonseJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
               // print(repsonseJson["result"])
                completion(repsonseJson["result"] as? [[String : AnyObject]] as AnyObject, true, "Success")
            }
            catch {
                completion(nil, false, responseString!)

            }
            
            
            }.resume()
    }

}
