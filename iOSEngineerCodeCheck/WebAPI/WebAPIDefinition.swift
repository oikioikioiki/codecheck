//
//  WebAPIDefinition.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/24.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation

enum FetchError: Error {
    
    case noNetwork
    case failed
    case noData
    case parameter
    case authError
}

enum HttpMethod: String {
    
    case get = "GET"
    case post = "POST"
    
    var name: String {
        get { return String(describing: self) }
    }
    
    var data: String {
        get { return self.rawValue }
    }
    
}

struct WebAPIEntity {
    
    let url: String
    let data: Any?
    let header: [String:String]?
    let method: HttpMethod
}
