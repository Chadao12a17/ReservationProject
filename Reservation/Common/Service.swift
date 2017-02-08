//
//  Services.swift
//  Saitama
//
//  Created by Tu Vu on on 07/02/17.
//  Copyright © 2017 MAC. All rights reserved.//

import UIKit


class Service {
    
    private var baseURL: String!
    
    // Initializing the base url
    required init(url: String) {
        baseURL = url
    }
    
    // Appending the base url with end point
    func urlString(path: String) -> URL {
        return URL(string:baseURL.appending(path))!
    }
}

extension Service:ServiceProtocol {
    
    func serviceRequestFor(path:String!, data:[String:Any]?, requestType:String, Success:(((responseData:Data?))  -> Void)!, failure: ((Void) -> Void)!, headers: [String: String]?){
        
        let urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
        
        let urlSession: URLSession = URLSession(configuration:urlSessionConfiguration)
        
        let url:URL  = urlString(path:path)
        
        var request:URLRequest  = URLRequest(url:url)

        request.httpMethod = requestType
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        if let _data = data {
            var inputData:Data?
            do {
                inputData =  try JSONSerialization.data(withJSONObject:_data, options:.prettyPrinted)
            }catch{
                debugPrint(error)
            }
            request.httpBody = inputData!
        }
      
        if let _header = headers {
            
          let _ =  _header.map({ (key, value) -> Bool in
            
            request.addValue(value, forHTTPHeaderField:key)
            
                return true
            })
        }
        urlSession.dataTask(with:request) { (data, response, error) in
            
            guard let _ = data, let _response:HTTPURLResponse = response as? HTTPURLResponse , error == nil else {
                failure()
                return
            }
            if _response.statusCode == 200 {
                Success(data)
            } else {
                failure()
            }
        }.resume()
    }
}

