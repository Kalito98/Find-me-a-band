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
    var tabBarController: UIViewController?
    var baseUrl: String = "https://find-me-a-band.herokuapp.com"
    var http: HttpRequester?
    var sessionManager: SessionManager?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.http = HttpRequester()
        self.sessionManager = SessionManager()
        
        sessionManager?.removeSession()
        
        if (sessionManager?.isLogged())! {
            tabBarAuthorized()
        } else {
            tabBarUnauthorized()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
    
    func tabBarAuthorized() {
        let storyboardName: String = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        tabBarController = storyboard.instantiateViewController(withIdentifier: "navigationControllerAuth")
        window?.rootViewController = tabBarController
    }
    
    func tabBarUnauthorized() {
        let storyboardName: String = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        tabBarController = storyboard.instantiateViewController(withIdentifier: "navigationControllerUnauth")
        window?.rootViewController = tabBarController
    }
}

