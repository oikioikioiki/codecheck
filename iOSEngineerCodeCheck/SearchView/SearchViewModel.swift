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
    var task: URLSessionTask?
    
    func searchRepositories(_ text: String, completeHandler: @escaping (Bool) -> Void) {
        
        if let url = URL(string: "https://api.github.com/search/repositories?q=\(text)") {
            task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                
                guard let self = self else {
                    completeHandler(false)
                    return
                }
                guard let data = data, error == nil else {
                    completeHandler(false)
                    return
                }
                
                do {
                    let jasonData = try JSONDecoder().decode(SearchRepoResponse.self, from: data)
                    if let items = jasonData.items {
                        self.repoList = items
                        completeHandler(true)
                    }
                } catch {
                    completeHandler(false)
                    print("JSONのパースエラー: \(error)")
                }
            }
            // これ呼ばなきゃリストが更新されません
            task?.resume()
        } else {
            completeHandler(false)
        }
    }
    
    func numberOfRepositories() -> Int {
        return repoList.count
    }
    
    func repoInfo(_ index: Int) -> RepoResponse {
        return repoList[index]
    }
}
