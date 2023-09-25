//
//  SearchInteractor.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/24.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchInteractor {
    
    func getRepositories(_ content: RepoSearchContent)
    
}

class SearchUserInteractor {
    
    var presenter: SearchPresenter?
    
    func setPresenter(presenter: SearchPresenter) {
        self.presenter = presenter
    }
    
}

extension SearchUserInteractor: SearchInteractor {
    
    func getRepositories(_ content: RepoSearchContent) {
        
        WebAPI.searchRepositories(data: SearchRepoRequest(content.repoName, page: content.page, perPage: 50), completeHandler: { [weak self] (data, response, error) in
            
            guard let self = self else { return }
            guard let data = data, error == nil else {
                self.presenter?.didFetchReposData(with: .failure(error as! FetchError), moreInfo: false)
                return
            }
            self.presenter?.didFetchReposData(with: .success(EntityUtils.repoResponseToRepoTableCellContent(data)), moreInfo: content.page > 1 ? true : false)
        })

    }
    
}
