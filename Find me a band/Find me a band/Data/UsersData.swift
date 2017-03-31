//
//  UsersData.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/31/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import UIKit
import Foundation

class UsersData: HttpRequesterDelegate {
    var delegate: UsersDataDelegate?
  
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
    
    func login(user: Dictionary<String, Any>) {
        self.http?.delegate = self
        self.http?.postJson(toUrl: "http://192.168.1.249:8080/auth/login", withBody: user)
    }
    
    func register(user: Dictionary<String, Any>) {
        self.http?.delegate = self
        self.http?.postJson(toUrl: "http://192.168.196.182:8080/auth/register", withBody: user)
    }
    
    func logout(user: Dictionary<String, Any>) {
        
    }
    
    func didReciveData(data: Any) {
        self.delegate?.didReciveUsersData(usersData: data)
    }
    
}
