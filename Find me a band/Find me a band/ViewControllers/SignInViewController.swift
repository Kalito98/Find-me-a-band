//
//  SignInViewController.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/24/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit
import SwiftSpinner

class SignInViewController: UIViewController, UsersDataDelegate {
    
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    var url: String {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return "\(appDelegate.baseUrl)"
        }
    }
    
    var userFactory: UserFactory?
    var usersData: UsersData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userFactory = UserFactory()
        usersData = UsersData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func SignIn(_ sender: UIButton) {
        SwiftSpinner.show("Signing In")
        let username = textFieldUserName.text
        let password = textFieldPassword.text
        
        let userJson = userFactory?.getSignInUser(withUsername: username!, andPassword: password!)
        
        usersData?.delegate = self
        usersData?.login(user: userJson!)
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
