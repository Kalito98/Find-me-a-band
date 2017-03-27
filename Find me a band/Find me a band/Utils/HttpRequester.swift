//
//  HttpRequester.swift
//  Find me a band
//
//  Created by Kaloyan Yanev on 3/23/17.
//  Copyright © 2017 Kaloyan Yanev. All rights reserved.
//

import Foundation

class HttpRequester {
    var delegate: HttpRequesterDelegate?
    
    func sendRequest(withMethod method: HttpMethod, toUrl urlString: String, withBody body: Any? = nil, andHeaders headers: Dictionary<String, String> = [:] ) {
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        
        if(body != nil) {
            request.httpBody = body as! Data?
        }
        
        headers.forEach() { request.setValue($0.value, forHTTPHeaderField: $0.key)}
        
        weak var weakSelf = self
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler:
            { bodyData, response, error in
                do {
                    let bodyRecived = try JSONSerialization.jsonObject(with: bodyData!, options: .allowFragments)
                    
                    if((response as! HTTPURLResponse).statusCode >= 400) {
                        let message = (body as! Dictionary<String, Any>)["error"] as! String
                        //needs error handling
                        return
                    }
                    
                    switch(method) {
                    case .get:
                        weakSelf?.delegate?.didReciveData(data: bodyRecived)
                    case .post:
                        weakSelf?.delegate?.didReciveData(data: bodyRecived)
                    default: break

                    }
                }
                catch {
                    
                }
            
        })
        
        dataTask.resume()
    }
    
    func post(toUrl urlString: String, withBody body: Any?, andHeaders headers: Dictionary<String, String> = [:]){
        self.sendRequest(withMethod: .post, toUrl: urlString, withBody: body, andHeaders: headers)
    }
    
    func postJson(toUrl urlString: String, withBody body: Any?, andHeaders headers: Dictionary<String, String> = [:]){
        var headersWithJson: Dictionary<String,String>= [:]
        headers.forEach(){ headersWithJson[$0.key] = $0.value }
        headersWithJson["Content-Type"] = "application/json"
        self.post(toUrl: urlString, withBody: body, andHeaders: headersWithJson)
    }
}
