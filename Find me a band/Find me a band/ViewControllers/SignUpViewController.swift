//
//  SignUpViewController.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/24/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit
import SwiftSpinner

class SignUpViewController: UIViewController, UsersDataDelegate {
    
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPass: UITextField!
    @IBOutlet weak var textFieldRole: UITextField!
    
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

    
    @IBAction func signUp(_ sender: UIButton) {
        SwiftSpinner.show("Signing Up")
        let username = textFieldUserName.text
        let email = textFieldEmail.text
        let password = textFieldPass.text
        let role = textFieldRole.text
        
        let userJson = userFactory?.getSignUpUser(withUsername: username!, withEmail: email!, withRole: role!, andPassword: password!)
        
        usersData?.delegate = self
        usersData?.register(user: userJson!)
    }
    
    func didReceiveUsersData(usersData: Any) {
        let userData = usersData as! Dictionary<String, Any>
        let user = UserModel(json: userData.values.first as! Dictionary<String, Any>)
        SwiftSpinner.hide()
    }
    
    func didReceiveUsersError(error: HttpError) {
        SwiftSpinner.hide()
    }


}
