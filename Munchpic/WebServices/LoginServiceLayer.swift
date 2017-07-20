//
//  LoginServiceLayer.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 31/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import Foundation
import Alamofire
class LoginServiceLayer: NSObject {
       
//    class func register(parameter:[String:Any]?,completion:@escaping (AnyObject?,Bool,String)->Void){
//        
//        Alamofire.request(Constants.kBaseUrl + Constants.KRegister, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            
//            if response.result.isSuccess {
//                completion(response as AnyObject,true,"Registered succesfully")
//            }
//        }
//    }
    
    
    class func register(relativeUrl :String,completion:@escaping (AnyObject?,Bool,String) ->Void){
        
        
        ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.KRegister, postbody: relativeUrl) { (response, status, msg) in
            if status == true {
                completion(response as? [[String : AnyObject]] as AnyObject , true, "Success")
            }
            else {
                completion(nil , false, msg)
                
            }
        }
        
    }
    
    func getUserInfo(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.KGetUserInfo, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    
  func activateUser(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.KActivation, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }

     func forgotPassword(parameter:String,completion:@escaping(AnyObject?,Bool,String)->Void){
        
        ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.KForgotPassword, postbody: parameter) { (response, status, msg) in
            if status == true {
                completion(response as? [[String : AnyObject]] as AnyObject , true, "Success")
            }
            else {
                completion(nil , false, msg)
                
            }
        }

    }
    
   
    
    func resetPassword(parameter:String,completion:@escaping(AnyObject?,Bool,String)->Void){
        
//        Alamofire.request(Constants.kBaseUrl + Constants.KResetPassword, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            
//            if response.result.isSuccess {
//            }
//        }
        
        
        ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.KResetPassword, postbody: parameter) { (response, status, msg) in
            if status == true {
                completion(response as? [[String : AnyObject]] as AnyObject , true, "Success")
            }
            else {
                completion(nil , false, msg)
                
            }
        }
    }
    
    
    func updateUserInfo(parameter:String,completion:@escaping(AnyObject?,Bool,String)->Void){
        
//        Alamofire.request(Constants.kBaseUrl + Constants.KUpdateUserInfo, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            
//            if response.result.isSuccess {
//            }
//        }
        
        
        ServiceLayer.excuteQuery(url: Constants.kBaseUrl + Constants.KUpdateUserInfo, postbody: parameter) { (response, status, msg) in
            if status == true {
                completion(response as? [[String : AnyObject]] as AnyObject , true, "Success")
            }
            else {
                completion(nil , false, msg)
                
            }
        }

        
        
        
    }
 }
