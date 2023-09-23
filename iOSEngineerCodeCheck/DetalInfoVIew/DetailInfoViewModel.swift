//
//  DetailInfoViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/23.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

class DetailInfoViewModel {
    var repoInfo: RepoResponse!
    
    var avatarImage: UIImage?
    
    var fullName: String {
        return repoInfo.fullName
    }
    
    var language: String {
        return "Written in \(repoInfo.language ?? "")"
    }
    
    var stars: String {
        return "\(repoInfo.stargazersCount) stars"
    }
    
    var watchers: String {
        return "\(repoInfo.watchersCount) watchers"
    }
    
    var forks: String {
        return "\(repoInfo.forksCount) forks"
    }
    
    var openIssues: String {
        return "\(repoInfo.openIssuesCount) open issues"
    }
    
    var avatarURL: URL? {
        guard let avatarImageURLString = repoInfo.owner?.avatarURL else {
            return nil
        }
        return URL(string: avatarImageURLString)
    }
    
    init(_ repoInfo: RepoResponse) {
        self.repoInfo = repoInfo
    }
    
    func getAvatarImage(imageURL: URL?, completeHandler: @escaping (Bool) -> Void) {
        
        guard let imageURL = imageURL else {
            completeHandler(false)
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
            
            guard let self = self else {
                completeHandler(false)
                return
            }
            
            guard let data = data, error == nil else {
                completeHandler(false)
                return
            }
            
            if let image = UIImage(data: data) {
                avatarImage = image
                completeHandler(true)
            } else {
                completeHandler(false)
            }
            }.resume()
        
        
    }
}
