//
//  AddBandViewController.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/25/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit
import SwiftSpinner

class AddBandViewController: UIViewController, HttpRequesterDelegate {

    @IBOutlet weak var textFieldBandName: UITextField!
    @IBOutlet weak var textFieldBandEmail: UITextField!
    @IBOutlet weak var textFieldBandPhone: UITextField!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createBand(_ sender: UIButton) {
        SwiftSpinner.show("Creating Band")
        let bandName = textFieldBandName.text
        let bandEmail = textFieldBandEmail.text
        let bandPhone = textFieldBandPhone.text
        
        
        let bandJson = [
            "name": bandName!,
            "contactPhone": bandPhone!,
            "contactEmail": bandEmail!,
            "bandMembers": []
        ] as [String : Any]
        
        self.http?.delegate = self
        self.http?.postJson(toUrl: "http://192.168.1.249:8080/band/create", withBody: bandJson)
    }
    
    func didReciveData(data: Any) {
        //let bandData = data as! Dictionary<String, Any>
        //let band = BandModel(json: bandData.values.first as! Dictionary<String, Any>)
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
