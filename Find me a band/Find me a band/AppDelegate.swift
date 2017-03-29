//
//  AppDelegate.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/23/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, HttpRequesterDelegate {

    var window: UIWindow?
    var tabBarController: UITabBarController?
    var baseUrl: String = "http://192.168.1.249:8080/auth/register"
    var http: HttpRequester?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        tabBarController = UITabBarController()
        tabBarAuthorized()
        self.http = HttpRequester()
        
        //crap and testing
        
        //crap and testing
        
        return true
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
    
    func tabBarAuthorized() {
        let storyboardName: String = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        let bandsTablleViewController: UIViewController? =  storyboard.instantiateViewController(withIdentifier: "bandsTableView")
        let addBandViewController: UIViewController? =  storyboard.instantiateViewController(withIdentifier: "addBandView")
        let accountViewController: UIViewController? = storyboard.instantiateViewController(withIdentifier: "accountView")
        
        tabBarController?.viewControllers = [bandsTablleViewController!, addBandViewController!, accountViewController!]
        
        window?.rootViewController = tabBarController
    }
    
    func tabBarUnauthorized() {
        let storyboardName: String = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        let bandsTablleViewController: UIViewController? =  storyboard.instantiateViewController(withIdentifier: "bandsTableView")
        let signUpViewController: UIViewController? = storyboard.instantiateViewController(withIdentifier: "signUpView")
        let signInViewController: UIViewController? = storyboard.instantiateViewController(withIdentifier: "signInView")
        
        tabBarController?.viewControllers = [bandsTablleViewController!, signInViewController!, signUpViewController!]
        
        window?.rootViewController = tabBarController
    }


}

