//
//  TabBarViewController.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/25/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.tag == 0) {
            //bands tab
        } else if(item.tag == 1) {
            //needs to be made with user session
            let userSession = false
            if (userSession) {
            } else {
                let storyboardName: String = "Main"
                let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
                let viewController: UIViewController? = storyboard.instantiateViewController(withIdentifier: "signInView")
                present(viewController!, animated: true, completion: { _ in})
            }

        } else if(item.tag == 2) {
            //needs to be made with user session
            let userSession = false
            if (userSession) {
            } else {
                let storyboardName: String = "Main"
                let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
                let viewController: UIViewController? = storyboard.instantiateViewController(withIdentifier: "signInView")
                present(viewController!, animated: true, completion: { _ in})
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
