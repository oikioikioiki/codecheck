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
    private let page: Int
    private let perPage: Int
    
    init(_ repo: String = "", page: Int = 1, perPage: Int = 30) {
        self.repo = repo
        self.page = page
        self.perPage = perPage
    }
        
    var queryItems: Any {
        
        return [
            URLQueryItem(name: "q", value: "\(repo)"),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(perPage)),
        ]
    }
}
