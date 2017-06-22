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
    
    func getPosts(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetPost, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                
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
    
    func GetCollections(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetCollections, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                }
        }
    }
    func GetIngredients(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetIngredients, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }

    func GetComments(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetComments, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    func GetCornivals(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetCornivals, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    func GetCollectionCategories(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetCollectionCategories, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    
    
    func GetLoves(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetLoves, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    func GetParticularPost(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetCollectionCategories, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    func GetTrends(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetTrends, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }

    func GetUserPosts(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kGetUserPosts, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    func insertLoves(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kInsertLoves, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    func insertCollections(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kInsertCollections, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    func insertComments(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kInsertComments, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    func insertPost(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kInsertPost, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    func deleteCollection(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.kDeleteCollection, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }

    

}
