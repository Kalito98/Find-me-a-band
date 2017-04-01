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
    
    var userFactory: UserFactory?
    var usersData: UsersData?
    var sessionManager: SessionManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userFactory = UserFactory()
        usersData = UsersData()
        sessionManager = SessionManager()
        
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
    
    func didReciveUsersData(usersData: Any) {
        let userData = usersData as! Dictionary<String, Any>
        let user = UserModel(json: userData.values.first as! Dictionary<String, Any>)
        sessionManager?.setSession(withUsername: (user?.username)!, withId: (user?.userId)!, andRole: (user?.role)!)
        SwiftSpinner.hide()
        
        let storyboardName: String = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabBarAuthorized") as? UITabBarController
        DispatchQueue.main.async{
            self.present(tabBarController!, animated: true, completion: nil)
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
