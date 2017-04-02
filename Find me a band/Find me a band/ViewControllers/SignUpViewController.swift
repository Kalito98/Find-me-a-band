//
//  SignUpViewController.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/24/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit
import SwiftSpinner
import Toaster

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
    
    func clearTextFields() {
        DispatchQueue.main.async {
            self.textFieldUserName.text = ""
            self.textFieldEmail.text = ""
            self.textFieldPass.text = ""
            self.textFieldRole.text = ""
        }
    }
    
    func didReceiveUsersData(usersData: Any) {
        SwiftSpinner.hide()
        clearTextFields()
        Toast(text: "Successfully signed up", duration: Delay.short).show()
    }
    
    func didReceiveUsersError(error: HttpError) {
        SwiftSpinner.hide()
        Toast(text: "Error signing up", duration: Delay.short).show()
    }


}
