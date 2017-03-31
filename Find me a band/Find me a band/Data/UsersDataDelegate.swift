//
//  UsersDelegate.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/31/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import Foundation

protocol UsersDataDelegate {
    func didReciveUsersData(usersData: Any)
    func didReceiveUsersError(error: HttpError)
}

extension UsersDataDelegate {
    func didReciveUsersData(usersData: Any) {
        
    }
    
    func didReceiveUsersError(error: HttpError) {
        
    }
}
