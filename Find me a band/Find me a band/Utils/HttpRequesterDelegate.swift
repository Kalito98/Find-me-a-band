//
//  HttpRequesterDelegate.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/27/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import Foundation

protocol HttpRequesterDelegate {
    func didReciveData(data: Any)
    func didReceiveError(error: HttpError)
    func didDeleteData()
}

extension HttpRequesterDelegate {
    func didReciveData(data: Any) {
        
    }
    
    func didReceiveError(error: HttpError) {
        
    }
    
    func didDeleteData() {
        
    }
}
