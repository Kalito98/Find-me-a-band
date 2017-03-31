//
//  BandsTableViewController.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/23/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit
import SwiftSpinner

class BandsTableViewController: UITableViewController, UITabBarDelegate, BandsDataDelegate {
    var bands: [BandModel] = []
    var bandsData: BandsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "band-cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bandsData = BandsData()
        self.loadBands()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be	 recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.bands.count
    }
    
    func loadBands() {
        self.bandsData?.delegate = self
        //DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250)) {
        //    SwiftSpinner.show("Loading Bands")
        //}
        //bandsData?.getAll()
    }
    
    func didReciveBandsData(data: Any) {
        let dataArray = data as! [Dictionary<String, Any>]
        self.bands = [BandModel].from(jsonArray: dataArray)!
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3500)) {
            SwiftSpinner.hide()
        }
        SwiftSpinner.hide()
    }
    
    


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "band-cell", for: indexPath)
        cell.textLabel?.text = self.bands[indexPath.row].name


        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
