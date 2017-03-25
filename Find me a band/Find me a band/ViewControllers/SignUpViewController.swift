//
//  SignUpViewController.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/24/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loadHome(_ sender: UIButton) {
        let storyboardName: String = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController: UIViewController? = storyboard.instantiateViewController(withIdentifier: "mainTabBarController")
        present(viewController!, animated: true, completion: { _ in})
    }

    @IBAction func loadSignIn(_ sender: UIButton) {
        let storyboardName: String = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController: UIViewController? = storyboard.instantiateViewController(withIdentifier: "signInView")
        present(viewController!, animated: true, completion: { _ in})
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        //sign up
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
