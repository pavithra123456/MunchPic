//
//  ServiceLayer.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import Alamofire
class ServiceLayer: NSObject {
    static let requestManager = ServiceLayer()
    private override init() {
        
    }
    
    class func getPosts(relativeUrl:String,completion:@escaping (AnyObject?,Bool,String)->Void){
        
        Alamofire.request(relativeUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                completion(response.result.value as AnyObject, true, "")
                // handle the response here
                
                
                //                if let jsonDictionary = response.result.value as? NSDictionary {
                //                    if let errorDictionary = jsonDictionary[Constants.kError] as? NSDictionary {
                //                        completion(nil,errorDictionary[Constants.KErrorMessage] as? String,false)
                //                    }
                //                    else if let resultDict = jsonDictionary[Constants.kResult] as? NSDictionary {
                //                        completion(resultDict,nil,true)
                //                    }
                //                    else {
                //                        completion(nil,Constants.kAGeneralError, false)
                //                    }
                //                }
                //                else {
                //                    completion(nil,Constants.kAGeneralError, false)
                //                }
                //                
                //            }
                //            else {
                //                completion(nil,response.result.error?.localizedDescription, false)
                //            }
            }
        }
    }
    
    class func getCollections(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetCollections, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                }
        }
    }
    class func GetIngredients(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetIngredients, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }

    class func GetComments(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetComments, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
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
    
    
    class func getLoves(completion:(AnyObject?,Bool,String)->Void){
        let parameter = ["userId":38]
        Alamofire.request(Constants.kBaseUrl + Constants.kGetLoves, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                
            }
        }
    }
    class func GetParticularPost(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetCollectionCategories, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    
    class func getTrends(completion:@escaping (AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetTrends, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                completion(response.result.value as  AnyObject,true,"Success")
            }
        }
    }

   class  func GetUserPosts(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetUserPosts, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    class func insertLoves(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kInsertLoves, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    class func insertCollections(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kInsertCollections, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
   class  func insertComments(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kInsertComments, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
   class  func insertPost(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kInsertPost, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    class func deleteCollection(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kDeleteCollection, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }

    class func getusetInfo(relativeUrl:String,completion:@escaping (AnyObject?,Bool,String)->Void) {
        Alamofire.request(relativeUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            if response.result.isSuccess {
               // completion(response.result.value as AnyObject, true, "")
            }
        }
    
    }

}
