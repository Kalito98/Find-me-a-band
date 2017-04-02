//
//  BandsDetailsViewController.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 4/2/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit
import Foundation
import SwiftSpinner
import Toaster

class BandsDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BandsDataDelegate {

    @IBOutlet weak var textLablName: UILabel!
    @IBOutlet weak var textLableEmail: UILabel!
    @IBOutlet weak var textLablePhone: UILabel!
    @IBOutlet weak var textLableGenre: UILabel!
    @IBOutlet weak var textLableOwner: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var bandMembersTableView: UITableView!
    @IBOutlet weak var buttonJoinBand: UIButton!
    
    var band: BandModel?
    var seesionManager: SessionManager?
    var bandsData: BandsData?
    var bandMembers: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seesionManager = SessionManager()
        bandsData = BandsData()
        bandMembers = band?.bandMembers
        
        if checkJoinButoon() {
            buttonJoinBand.isHidden = true
        }

        self.bandMembersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "bandmember-cell")
        
        loadBand()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.bandMembers?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bandmember-cell", for: indexPath)
        let bandMember = self.bandMembers?[indexPath.row]
        
        cell.textLabel?.text = bandMember
        
        return cell
    }
    
    func loadBand() {
        let name = band?.name
        let email = band?.email
        let phone = band?.phone
        let genre = band?.genre
        let owner = band?.creator
        DispatchQueue.main.async {
            self.textLablName.text = "\(name! as String)"
            self.textLableEmail.text = "Email: \(email! as String)"
            self.textLablePhone.text = "Phone: \(phone! as String)"
            self.textLableGenre.text = "Genre: \(genre! as String)"
            self.textLableOwner.text = "Owner: \(owner! as String)"
        }
    }
    
    func checkJoinButoon() -> Bool {
        if (seesionManager?.isLogged())! {
            let currentUsername = seesionManager?.getUsername()
        
            for i in 0..<(self.bandMembers?.count)! {
                let username = self.band?.bandMembers?[i]
                if currentUsername == username {
                    return true
                }
            }
        } else {
            return true
        }
        return false
    }
    
    @IBAction func joinBand(_ sender: UIButton) {
        bandsData?.delegate = self
        let username = seesionManager?.getUsername()
        
        let member = [
            "_bandId": band?.bandId!,
            "username": "\(username!)"
        ]
        SwiftSpinner.show("Joining Band")
        bandMembers?.append(username!)
        bandsData?.putBandMember(member: member)
        Toast(text: "Successfully joined band", duration: Delay.short).show()
        buttonJoinBand.isHidden = true
    }
    
    func didReceiveBandsData(bandsData: Any) {
        DispatchQueue.main.async {
            self.bandMembersTableView.reloadData()
        }
        SwiftSpinner.hide()
    }
    
    func didReceiveBandsError(error: HttpError) {
        SwiftSpinner.hide()
    }
}
