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
    
    let userId: Int?
    let username: String?
    let email: String?
    let authtoken: String?
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        self.userId = "id" <~~ json
        self.username = "username" <~~ json
        self.email = "email" <~~ json
        self.authtoken = "authtoken" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.userId,
            "username" ~~> self.username,
            "email" ~~> self.email,
            "authtoken" ~~> self.authtoken
            ])
    }
    
}

		
