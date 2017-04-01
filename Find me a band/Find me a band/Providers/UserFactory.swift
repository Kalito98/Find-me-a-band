//
//  UserFactory.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/30/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import Foundation

class UserFactory {

    func getSignUpUser(withUsername username: String, withEmail email: String, withRole role: String, andPassword password: String) -> Dictionary<String, Any> {
        let userJson = [
            "username": username,
            "passHash": password,
            "email": email,
            "role": role
        ]
        
        let user = UserModel(json: userJson)
        
        return user!.toJSON()! as Dictionary<String, Any>
    }
    
    func getSignInUser(withUsername username: String, andPassword password: String) -> Dictionary<String, Any> {
        let userJson = [
            "username": username,
            "passHash": password
        ]
        
        let user = UserModel(json: userJson)
        
        return user!.toJSON()! as Dictionary<String, Any>
    }
}
