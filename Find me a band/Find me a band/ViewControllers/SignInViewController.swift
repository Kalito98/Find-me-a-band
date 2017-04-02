//
//  SignInViewController.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/24/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit
import SwiftSpinner
import Toaster

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func SignIn(_ sender: UIButton) {
        SwiftSpinner.show("Signing In")
        let username = textFieldUserName.text
        let password = textFieldPassword.text
        
        let userJson = userFactory?.getSignInUser(withUsername: username!, andPassword: password!)
        
        usersData?.delegate = self
        usersData?.login(user: userJson!)
    }
    
    func didReceiveUsersData(usersData: Any) {
        let userData = usersData as! Dictionary<String, Any>
        let user = UserModel(json: userData.values.first as! Dictionary<String, Any>)
        sessionManager?.setSession(withUsername: (user?.username)!, withId: (user?.userId)!, andRole: (user?.role)!)
        SwiftSpinner.hide()
        Toast(text: "Successfully signed in", duration: Delay.short).show()
        
        let storyboardName: String = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "navigationControllerAuth") as? UINavigationController
        DispatchQueue.main.async{
            self.present(tabBarController!, animated: true, completion: nil)
        }
    }
    
    func didReceiveUsersError(error: HttpError) {
        SwiftSpinner.hide()
        Toast(text: "Error signing in", duration: Delay.short).show()
    }

}
