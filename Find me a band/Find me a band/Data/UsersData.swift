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
        self.http?.postJson(toUrl: "\(url)/auth/login", withBody: user)
    }
    
    func register(user: Dictionary<String, Any>) {
        self.http?.delegate = self
        self.http?.postJson(toUrl: "\(url)/auth/register", withBody: user)
    }
    
    func logout(user: Dictionary<String, Any>) {
        
    }
    
    func didReceiveData(data: Any) {
        self.delegate?.didReceiveUsersData(usersData: data)
    }
    
    func didReceiveError(error: HttpError) {
        self.delegate?.didReceiveUsersError(error: error)
    }
    
}
