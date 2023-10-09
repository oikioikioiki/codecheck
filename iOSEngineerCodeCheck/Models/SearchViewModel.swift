//
//  SearchViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/22.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

class RepoTableCellContent {
    
    let name: String
    let language: String?
    let stars: Int
    let watchers: Int
    let forks: Int
    let openIssues: Int
    let avatarImageURL: String?
    let htmlURL: String
    var image: UIImage?
    
    init(name: String, language: String?, stars: Int, watchers: Int, forks: Int, openIssues: Int, avatarImageURL: String?, htmlURL: String) {
        self.name = name
        self.language = language
        self.stars = stars
        self.watchers = watchers
        self.forks = forks
        self.openIssues = openIssues
        self.avatarImageURL = avatarImageURL
        self.htmlURL = htmlURL
    }
    
    func updateData(image: UIImage){
        self.image = image
    }
}

class RepoSearchContent {
    
    var repoName: String
    var page: Int
    var lastListCount: Int = 0
    var isNotLoadingNewElement: Bool = true
    var isNotFinal: Bool = true
    
    init(repoName: String, page: Int = 1) {
        self.repoName = repoName
        self.page = page
    }
    
    func updatePage(_ lastCunt: Int = 0) {
        self.page += 1
        self.lastListCount = lastCunt
    }
    
    func setLoading() {
        self.isNotLoadingNewElement = false
    }
    
    func setFinishLoading() {
        self.isNotLoadingNewElement = true
    }
    
    func setFinal() {
        self.isNotFinal = false
    }
}
