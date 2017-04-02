//
//  SessionManager.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 4/1/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import Foundation

class SessionManager {
    let userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults.standard
    }
    
    func setSession(withUsername username: String, withId id: String, andRole role: String) {
        userDefaults.set(username, forKey: "username")
        userDefaults.set(id, forKey: "id")
        userDefaults.set(role, forKey: "role")
    }
    
    func removeSession() {
        userDefaults.removeObject(forKey: "username")
        userDefaults.removeObject(forKey: "id")
        userDefaults.removeObject(forKey: "role")
    }
    
    func getUsername() -> String {
        return userDefaults.value(forKey: "username") as! String
    }
    
    func getRole() -> String {
        return userDefaults.value(forKey: "role") as! String
    }
    
    func isLogged() -> Bool {
        if self.userDefaults.value(forKey: "username") == nil {
            return false
        }
        return true
    }
}
