//
//  SearchViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/22.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    var repoList: [RepoResponse] = []
    
    func getRepositories(_ text: String, completeHandler: @escaping (Bool) -> Void) {
        
        WebAPI.searchRepositories(data: SearchRepoRequest(text), completeHandler: { [weak self] (data, response, error) in
            
            guard let self = self, let data = data, error == nil else {
                completeHandler(false)
                return
            }
            
            self.repoList = data
            completeHandler(true)
        })

    }
    
    func numberOfRepositories() -> Int {
        return repoList.count
    }
    
    func repoInfo(_ index: Int) -> RepoResponse {
        return repoList[index]
    }
}
