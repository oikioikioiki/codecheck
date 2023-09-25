//
//  Response.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/22.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation

struct SearchRepoResponse: Codable {
    
    let totalCount: Int
    let incompleteResults: Bool?
    let items: [RepoResponse]?
    
    enum CodingKeys: String, CodingKey {
        
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items = "items"
    }
}

struct RepoResponse: Codable {
    
    let fullName: String
    let language: String?
    let htmlURL: String
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let owner: OwnerResponse?
    

    enum CodingKeys: String, CodingKey {
        
        case fullName = "full_name"
        case language = "language"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case htmlURL = "html_url"
        case owner = "owner"
    }
}

struct OwnerResponse: Codable {
    
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        
        case avatarURL = "avatar_url"
    }
}
