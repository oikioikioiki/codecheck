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
    func updateDataImage(url: String, at: Int)
    
}

class SearchUserInteractor {
    
    var presenter: SearchPresenter?
    private var apiClient: APIClientProtocol?
    
    func setPresenter(presenter: SearchPresenter, apiClient: APIClientProtocol? = WebAPI()) {
        self.presenter = presenter
        self.apiClient = apiClient
    }
    
}

extension SearchUserInteractor: SearchInteractor {
    
    func getRepositories(_ content: RepoSearchContent) {
        
        apiClient?.searchRepositories(data: SearchRepoRequest(content.repoName, page: content.page, perPage: 50), completeHandler: { [weak self] (result) in
            
            guard let self = self else { return }

            switch result {
            case .success(let data):
                self.presenter?.didFetchReposData(with: .success(EntityUtils.repoResponseToRepoTableCellContent(data)), moreInfo: content.page > 1 ? true : false)
                break
            case .failure(let error):
                self.presenter?.didFetchReposData(with: .failure(error), moreInfo: false)
                break
            }
            
        })

    }
    
    func updateDataImage(url: String, at: Int) {
        
        apiClient?.getImageData(url: url, completeHandler: { [weak self] (result) in
            
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.presenter?.updateCellData(with: .success(data), at: at)
                break
            case .failure(let error):
                self.presenter?.updateCellData(with: .failure(error), at: at)
                break
            }
        })
    }
    
}
