//
//  BandModel.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/30/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import Foundation
import Gloss

struct BandModel: Decodable {
    
    let bandId: String?
    let name: String?
    let email: String?
    let phone: String?
    let bandMembers: Array<String>?
    let creator: String?
    let genre: String?
    
    init?(json: JSON) {
        self.bandId = "_id" <~~ json
        self.name = "name" <~~ json
        self.email = "contactEmail" <~~ json
        self.phone = "contactPhone" <~~ json
        self.bandMembers = "bandMembers" <~~ json
        self.creator = "creator" <~~ json
        self.genre = "genre" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "_id" ~~> self.bandId,
            "name" ~~> self.name,
            "contactEmail" ~~> self.email,
            "contactPhone" ~~> self.phone,
            "bandMembers" ~~> self.bandMembers,
            "creator" ~~> self.creator,
            "genere" ~~> self.genre
            ])
    }
    
}
