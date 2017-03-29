//
//  UserModel.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/27/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//	

import Foundation
import Gloss	

struct UserModel: Decodable {
    
    let userId: String?
    let username: String?
    let email: String?
    let passHash: String?
    
    init?(json: JSON) {
        self.userId = "_id" <~~ json
        self.username = "username" <~~ json
        self.email = "email" <~~ json
        self.passHash = "passHash" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "_id" ~~> self.userId,
            "username" ~~> self.username,
            "email" ~~> self.email,
            "passHash" ~~> self.passHash
            ])
    }
    
}

		
