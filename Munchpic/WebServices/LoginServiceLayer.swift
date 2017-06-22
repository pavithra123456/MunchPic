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
    class func login(parameter:[String:AnyObject]?,completion:@escaping (AnyObject?,Bool,String) ->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.KLogin, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                completion(response as AnyObject,true,"Login succesfully")
            }
            else {
                completion(nil,true,(response.error?.localizedDescription)!)
            }
        }
    }
    
    class func register(parameter:[String:Any]?,completion:@escaping (AnyObject?,Bool,String)->Void){
        
        Alamofire.request(Constants.kBaseUrl + Constants.KRegister, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                completion(response as AnyObject,true,"Registered succesfully")
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

    func forgotPassword(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.KForgotPassword, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    
    func resetPassword(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.KResetPassword, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
    func updateUserInfo(parameter:[String:AnyObject]?,completion:(AnyObject?,Bool,String)){
        
        Alamofire.request(Constants.kBaseUrl + Constants.KUpdateUserInfo, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
            }
        }
    }
 }
