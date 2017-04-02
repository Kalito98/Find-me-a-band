//
//  BandsDataDelegate.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/31/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import Foundation

protocol BandsDataDelegate {
    func didReceiveBandsData(bandsData: Any)
    func didReceiveBandsError(error: HttpError)
    func didDeleteBands()
}

extension BandsDataDelegate {
    func didReceiveBandsData(bandsData: Any) {
        
    }
    
    func didReceiveBandsError(error: HttpError) {
        
    }
    
    func didDeleteBands() {
        
    }
}
