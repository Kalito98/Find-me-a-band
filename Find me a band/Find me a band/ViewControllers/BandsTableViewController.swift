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
        bandsData = BandsData()
        
        let bandsCell = UINib(nibName: "BandTableViewCell", bundle: nil)
        self.tableView.register(bandsCell, forCellReuseIdentifier: "band-cell")
        self.tableView.rowHeight = 70
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadBands()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bands.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDetails(band: self.bands[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "band-cell", for: indexPath) as! BandTableViewCell
        cell.textLableBandName.text = "Genre: \(self.bands[indexPath.row].genre!)"
        cell.textLableBandCreator.text = "Creator: \(self.bands[indexPath.row].creator!)"
        cell.textLableBandGenre.text = self.bands[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func loadBands() {
        self.bandsData?.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
            SwiftSpinner.show("Loading Bands")
        }
        bandsData?.getAll()
    }
    
    func showDetails(band: BandModel) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "bandsDetailsView") as! BandsDetailsViewController
        nextVC.band = band
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func didReceiveBandsData(bandsData: Any) {
        let dataArray = bandsData as! [Dictionary<String, Any>]
        self.bands = [BandModel].from(jsonArray: dataArray)!
        weak var weakSelf = self
        
        DispatchQueue.main.async {
            weakSelf?.tableView.reloadData()
        }
        SwiftSpinner.hide()
    }
    
    func didReceiveBandsError(error: HttpError) {
        SwiftSpinner.hide()
    }
    

    

}
