//
//  EntityUtils.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/24.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation

class EntityUtils {
    
    static func repoResponseToRepoTableCellContent(_ list: [RepoResponse]) -> [RepoTableCellContent] {
        
        var resultRepoList: [RepoTableCellContent] = []
        if list.isEmpty {
            return resultRepoList
        }
        
        for element in list {
            resultRepoList.append(RepoTableCellContent(name: element.fullName, language: element.language, stars: element.stargazersCount, watchers: element.watchersCount, forks: element.forksCount, openIssues: element.openIssuesCount, avatarImageURL: element.owner?.avatarURL, htmlURL: element.htmlURL))
        }
        
        return resultRepoList
    }
}
