//
//  SearchRepoRequest.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/24.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation

class SearchRepoRequest {
    
    private let repo: String
    
    init(_ repo: String = ""){
        self.repo = repo
    }
    
    var queryItems: Any {
        
        return [
            URLQueryItem(name: "q", value: "\(repo)"),
        ]
    }
}
