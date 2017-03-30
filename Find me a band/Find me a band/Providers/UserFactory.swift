//
//  UserFactory.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/30/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import Foundation

class UserFactory {

    func getSignUpUser(withUsername username: String, withEmail email: String, withPassword password: String) -> JSONSerialization {
        let userJson = [
            "username": username,
            "passHash": password,
            "email": email
        ]
        
        let user = UserModel(json: userJson)
        
        return user?.toJSON() as JSONSerialization
    }
}
