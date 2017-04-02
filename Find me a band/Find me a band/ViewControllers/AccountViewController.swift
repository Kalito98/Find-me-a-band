//
//  AccountViewController.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/25/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit
import SwiftSpinner

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
        
        self.bandsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "band-cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadBands()
        self.loadProfile()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be	 recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.bands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "band-cell", for: indexPath)
        cell.textLabel?.text = self.bands[indexPath.row].name
        
        return cell
    }
    

    @IBAction func signOut(_ sender: UIButton) {
        sessionManager?.removeSession()
        let storyboardName: String = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabBarUnauthorized") as? UITabBarController
        self.present(tabBarController!, animated: true, completion: nil)
    }
    
    func loadBands() {
        self.bandsData?.delegate = self
        var username = Dictionary<String, Any>()
        username["username"] = sessionManager?.getUsername()
        SwiftSpinner.show("Loading Account")
        bandsData?.getByUser(username: username)
    }
    
    func loadProfile() {
        let username = sessionManager?.getUsername()
        DispatchQueue.main.async {
            self.labelHello.text = "Hello, \(username! as String)"
        }
    }

    
    func didReciveBandsData(bandsData: Any) {
        let dataArray = bandsData as! [Dictionary<String, Any>]
        self.bands = [BandModel].from(jsonArray: dataArray)!
        DispatchQueue.main.async {
            self.labelBandsCreated.text = "Bands Created: \(self.bands.count)"
            self.bandsTableView.reloadData()
        }
        SwiftSpinner.hide()
    }
    
    func didReceiveBandsError(error: HttpError) {
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
