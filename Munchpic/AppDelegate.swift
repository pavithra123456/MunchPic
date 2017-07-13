//
//  AppDelegate.swift
//  Munchpic
//
//  Created by Pavithra Jayanna on 27/05/17.
//  Copyright © 2017 Pavithra Jayanna. All rights reserved.
//

import UIKit
import GoogleSignIn
import Google
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var  isForWindowDetailView = false


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        if let userId =  UserDefaults.standard.value(forKey: "userId") {
            print(userId)
            let stroyBoard = UIStoryboard(name: "Main", bundle: nil)
            let askFeedbackVc = stroyBoard.instantiateViewController(withIdentifier: "DashBoard")
            self.window?.rootViewController = askFeedbackVc
            
        
        }

        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        // Google Auth
        let googleHandle = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        // Facebook Auth
        let facebookHandle = SDKApplicationDelegate.shared.application(app, open: url, options: options)
        
//        //LinkedIn Auth
//        let linkedInHandle = LISDKCallbackHandler.application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
//        //DropBox
//        if let authResult = DropboxClientsManager.handleRedirectURL(url) {
//            switch authResult {
//            case .success:
//                print("Success! User is logged into Dropbox.")
//            case .cancel:
//                print("Authorization flow was manually canceled by user!")
//            case .error(_, let description):
//                print("Error: \(description)")
//            }
//            return true
//        }
        
        
        return googleHandle || facebookHandle
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

