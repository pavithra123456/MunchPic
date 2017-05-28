//
//  ServiceRequestManager.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//
 import UIKit
import Alamofire

class ServiceRequestManager: NSObject {
static let requestManager = ServiceRequestManager()
    func getPosts(){
        Alamofire.request(Constants.kBaseUrl + Constants.kGetPost, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
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
