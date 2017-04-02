//
//  BandsData.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/31/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit
import Foundation

class BandsData: HttpRequesterDelegate {
    var delegate: BandsDataDelegate?
    
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
    
    func getAll() {
        self.http?.delegate = self
        self.http?.get(fromUrl: "http://192.168.1.249:8080/band/getall")
    }
    
    func getByUser(username: Dictionary<String, Any>) {
        self.http?.delegate = self
        self.http?.postJson(toUrl: "http://192.168.1.249:8080/band/getByUser", withBody: username)
    }
    
    func deleteBand(band: Dictionary<String, Any>) {
        self.http?.delegate = self
        self.http?.deleteJson(atUrl: "http://192.168.1.249:8080/band/delete", withBody: band)
    }
    
    func didReciveData(data: Any) {
        self.delegate?.didReciveBandsData(bandsData: data)
    }
    
    func didReceiveError(error: HttpError) {
        self.delegate?.didReceiveBandsError(error: error)
    }
    func didDeleteData() {
        self.delegate?.didDeleteBands()
    }
    
}

