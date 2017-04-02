//
//  AccountViewController.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/25/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit
import SwiftSpinner
import Toaster

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BandsDataDelegate {
    var sessionManager: SessionManager?
    var bands: [BandModel] = []
    var bandsData: BandsData?
    
    @IBOutlet weak var labelBandsCreated: UILabel!
    @IBOutlet weak var labelHello: UILabel!
    @IBOutlet weak var bandsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bandsData = BandsData()
        sessionManager = SessionManager()
        
        let bandsCell = UINib(nibName: "BandTableViewCell", bundle: nil)
        self.bandsTableView.register(bandsCell, forCellReuseIdentifier: "band-cell")
        self.bandsTableView.rowHeight = 70
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadBands()
        self.loadProfile()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "band-cell", for: indexPath) as! BandTableViewCell
        cell.textLableBandName.text = "Genre: \(self.bands[indexPath.row].genre!)"
        cell.textLableBandCreator.text = "Creator: \(self.bands[indexPath.row].creator!)"
        cell.textLableBandGenre.text = self.bands[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteBandAt(index: indexPath.row)
        } else if editingStyle == .insert {
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDetails(band: self.bands[indexPath.row])
    }

    @IBAction func signOut(_ sender: UIButton) {
        sessionManager?.removeSession()
        let storyboardName: String = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "navigationControllerUnauth") as? UINavigationController
        self.present(tabBarController!, animated: true, completion: nil)
    }
    
    func loadBands() {
        self.bandsData?.delegate = self
        var username = Dictionary<String, Any>()
        username["username"] = sessionManager?.getUsername()
        SwiftSpinner.show("Loading Account")
        bandsData?.getByUser(username: username)
    }
    
    func showDetails(band: BandModel) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "bandsDetailsView") as! BandsDetailsViewController
        nextVC.band = band
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func loadProfile() {
        let username = sessionManager?.getUsername()
        weak var weakSelf = self
        DispatchQueue.main.async {
            weakSelf?.labelHello.text = "Hello, \(username! as String)"
        }
    }
    
    func deleteBandAt(index: Int) {
        self.bandsData?.delegate = self
        SwiftSpinner.show("Deleting Band")
        let band = self.bands[index]
        bandsData?.deleteBand(band: band.toJSON()! as Dictionary<String, Any>)
    }

    
    func didReceiveBandsData(bandsData: Any) {
        let dataArray = bandsData as! [Dictionary<String, Any>]
        self.bands = [BandModel].from(jsonArray: dataArray)!
        weak var weakSelf = self
        DispatchQueue.main.async {
            weakSelf?.labelBandsCreated.text = "Bands Created: \(self.bands.count)"
            weakSelf?.bandsTableView.reloadData()
        }
        SwiftSpinner.hide()
    }
    
    func didReceiveBandsError(error: HttpError) {
        SwiftSpinner.hide()
    }
    
    func didDeleteBands() {
        self.loadBands()
        SwiftSpinner.hide()
        Toast(text: "Successfully deleted band", duration: Delay.short).show()
    }

}
