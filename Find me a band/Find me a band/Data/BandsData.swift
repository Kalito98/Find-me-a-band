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
    
    func didReciveData(data: Any) {
        self.delegate?.didReciveBandsData(bandsData: data)
    }
    
}

