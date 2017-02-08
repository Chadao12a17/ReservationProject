//
//  serviceProtocol.swift
//  RobotsAndPencilsCodingTest
//
//  Created by Tu Vu on on 07/02/17.
//  Copyright © 2017 MAC. All rights reserved.
//
import Foundation

protocol  ServiceProtocol {
    
    init(url: String)
    
    func serviceRequestFor(path:String!,data:[String:Any]?,requestType:String,Success:((Data?)  -> Void)!,failure: ((Void) -> Void)!,headers: [String: String]?)
    
}
