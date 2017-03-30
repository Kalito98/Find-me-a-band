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
    
    func get(fromUrl urlString: String, andHeaders headers: Dictionary<String, String> = [:]){
        self.send(withMethod: .get, toUrl: urlString, withBody: nil, andHeaders: headers)
    }
    
    func post(toUrl urlString: String, withBody bodyInput: Any?, andHeaders headers: Dictionary<String, String> = [:]){
        self.send(withMethod: .post, toUrl: urlString, withBody: bodyInput, andHeaders: headers)
    }
    
    func delete(atUrl urlString: String, withHeaders headers: Dictionary<String, String> = [:]) {
        self.send(withMethod: .delete, toUrl: urlString, andHeaders: headers)
    }
    
    func put(atUrl urlString: String, withBody bodyInput: Any?, andHeaders headers: Dictionary<String, String> = [:]) {
        self.send(withMethod: .put, toUrl: urlString, withBody: bodyInput, andHeaders: headers)
    }
    
    func postJson(toUrl urlString: String, withBody bodyInput: Any?, andHeaders headers: Dictionary<String, String> = [:]){
        var headersWithJson: Dictionary<String,String>= [:]
        headers.forEach(){ headersWithJson[$0.key] = $0.value }
        headersWithJson["Content-Type"] = "application/json"
        self.post(toUrl: urlString, withBody: bodyInput, andHeaders: headersWithJson)
    }
    
    func putJson(atUrl urlString: String, withBody bodyInput: Any?, andHeaders headers: Dictionary<String, String> = [:]){
        var headersWithJson: Dictionary<String,String>= [:]
        headers.forEach(){ headersWithJson[$0.key] = $0.value }
        headersWithJson["Content-Type"] = "application/json"
        self.put(atUrl: urlString, withBody: bodyInput, andHeaders: headersWithJson)
    }
    
    func send(withMethod method: HttpMethod,
              toUrl urlString: String,
              withBody bodyInput: Any? = nil,
              andHeaders headers: Dictionary<String, String> = [:]) {
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        
        if(bodyInput != nil) {
            do {
                let body = try JSONSerialization.data(withJSONObject: bodyInput!, options: .prettyPrinted)
                request.httpBody = body
            } catch {
            }
        }
        
        
        headers.forEach() { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        weak var weakSelf = self
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler:
            { bodyData, response, error in
                do {
                    let body = try JSONSerialization.jsonObject(with: bodyData!, options: .allowFragments)
                    
                    if((response as! HTTPURLResponse).statusCode >= 400) {
                        let message = (body as! Dictionary<String, Any>)["error"] as! String
                        weakSelf?.delegate?.didReceiveError(error: .api(message))
                        return
                    }
                    
                    switch(	method) {
                    case .delete:
                        weakSelf?.delegate?.didDeleteData()
                    default:
                        weakSelf?.delegate?.didReciveData(data: body)
                    }
                }
                catch {
                    weakSelf?.delegate?.didReceiveError(error: .api(error.localizedDescription))
                }
        })
        
        dataTask.resume()
    }

}
