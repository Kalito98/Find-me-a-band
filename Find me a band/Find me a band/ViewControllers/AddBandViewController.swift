//
//  AddBandViewController.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/25/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit
import SwiftSpinner

class AddBandViewController: UIViewController, BandsDataDelegate {

    @IBOutlet weak var textFieldBandName: UITextField!
    @IBOutlet weak var textFieldBandEmail: UITextField!
    @IBOutlet weak var textFieldBandPhone: UITextField!
    @IBOutlet weak var textFieldGenere: UITextField!
    
    var url: String {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return "\(appDelegate.baseUrl)"
        }
    }
    
    var sessionManager: SessionManager?
    var bandsData: BandsData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionManager = SessionManager()
        bandsData = BandsData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func createBand(_ sender: UIButton) {
        SwiftSpinner.show("Creating Band")
        let bandName = textFieldBandName.text
        let bandEmail = textFieldBandEmail.text
        let bandPhone = textFieldBandPhone.text
        let genere = textFieldGenere.text
        let bandCreator = sessionManager?.getUsername()
        print(bandCreator!)
        
        let bandJson = [
            "name": bandName!,
            "contactPhone": bandPhone!,
            "contactEmail": bandEmail!,
            "bandMembers": [],
            "creator": bandCreator! as String,
            "genre": genere!
        ] as [String : Any]
        
        self.bandsData?.delegate = self
        self.bandsData?.createBand(band: bandJson)
    }
    
    func didReceiveBandsData(bandsData: Any) {
        //let bandData = data as! Dictionary<String, Any>
        //let band = BandModel(json: bandData.values.first as! Dictionary<String, Any>)
        SwiftSpinner.hide()
    }
    
    func didReceiveBandsError(error: HttpError) {
        SwiftSpinner.hide()
    }
    
    
}
