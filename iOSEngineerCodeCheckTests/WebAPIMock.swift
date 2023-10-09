//
//  WebAPIMock.swift
//  iOSEngineerCodeCheckTests
//
//  Created by ふりかけ on R 5/10/09.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck
import UIKit

var mockRepoResponse: [RepoResponse] {
    var responses: [RepoResponse] = []
    
    for i in 1...30 {
        let repo = RepoResponse(
            fullName: "Repo \(i)",
            language: "Swift",
            htmlURL: "https://github.com/repo\(i)",
            stargazersCount: i * 100,
            watchersCount: i * 50,
            forksCount: i * 25,
            openIssuesCount: i * 10,
            owner: OwnerResponse(avatarURL: "https://github.com/avatar\(i).png")
        )
        
        responses.append(repo)
    }
    
    return responses
}

let mockImage: UIImage = UIImage(named: "noImage")!

