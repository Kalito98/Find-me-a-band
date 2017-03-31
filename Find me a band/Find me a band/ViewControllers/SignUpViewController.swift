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

    
    @IBAction func signUp(_ sender: UIButton) {
        SwiftSpinner.show("Signing Up")
        let username = textFieldUserName.text
        let email = textFieldEmail.text
        let password = textFieldPass.text
        
        let userJson = userFactory?.getSignUpUser(withUsername: username!, withEmail: email!, andPassword: password!)
        
        usersData?.delegate = self
        usersData?.register(user: userJson!)
    }
    
    func didReciveUsersData(usersData: Any) {
        print(usersData)
        //let userData = data as! Dictionary<String, Any>
        //let user = UserModel(json: userData.values.first as! Dictionary<String, Any>)
        SwiftSpinner.hide()
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
