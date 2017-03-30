//
//  SignUpViewController.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/24/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, HttpRequesterDelegate {
    
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPass: UITextField!
    
    
    var url: String {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return "\(appDelegate.baseUrl)"
        }
    }
    var http: HttpRequester? {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.http
        }
    }
    
    var userFactory: UserFactory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userFactory = UserFactory()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func signUp(_ sender: UIButton) {
        let username = textFieldUserName.text
        let email = textFieldEmail.text
        let password = textFieldPass.text
        
        let userJson = userFactory?.getSignUpUser(withUsername: username!, withEmail: email!, andPassword: password!)
        
        self.http?.delegate = self
        self.http?.postJson(toUrl: "http://192.168.1.249:8080/auth/register", withBody: userJson)
    }
    
    func didReciveData(data: Any) {
        print(data)
        let userData = data as! Dictionary<String, Any>
        let user = UserModel(json: userData.values.first as! Dictionary<String, Any>)
        print(user)
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
