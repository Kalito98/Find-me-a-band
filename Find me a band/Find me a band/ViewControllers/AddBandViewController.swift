//
//  AddBandViewController.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/25/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit

class AddBandViewController: UIViewController {

    @IBOutlet weak var textFieldBandName: UITextField!
    @IBOutlet weak var textFieldBandEmail: UITextField!
    @IBOutlet weak var textFieldBandPhone: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createBand(_ sender: UIButton) {
        let bandName = textFieldBandName.text
        let bandEmail = textFieldBandEmail.text
        let bandPhone = textFieldBandPhone.text
        
        
        let userJson = [
            "username": username,
            "passHash": password,
            "email": email
        ]
        
        self.http?.delegate = self
        self.http?.postJson(toUrl: "http://192.168.196.182:8080/auth/register", withBody: userJson)
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
