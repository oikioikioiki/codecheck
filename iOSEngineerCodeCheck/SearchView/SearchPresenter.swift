//
//  SearchPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/24.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchPresenter {
    
    //View
    func searchRepositories(text: String?)
    func didTappedRepoTableCell(info: RepoTableCellContent)
    
    //Interactor
    func didFetchReposData(with result: Result<[RepoTableCellContent], Error>)
    
}

class SearchUserPresenter {
    
    weak var view: SearchView?
    var router: SearchRouter
    var interactor: SearchInteractor
    
    init(view: SearchView, interactor: SearchInteractor, router: SearchRouter) {
        self.view = view
        self.router = router
        self.interactor = interactor
        
    }
    
}

extension SearchUserPresenter: SearchPresenter {
    
    func searchRepositories(text: String?) {
        
        if let searchText = text, searchText.isNotEmpty {
            interactor.getRepositories(searchText)
        }
    }
    
    func didTappedRepoTableCell(info: RepoTableCellContent) {
        router.showRepoDetailInfoView(data: info)
    }
    
    func didFetchReposData(with result: Result<[RepoTableCellContent], Error>) {
        
        switch result {
        case .success(let repoListInfo):
            if repoListInfo.isEmpty {
                return
            }
            view?.updateRepoList(list: repoListInfo)
            break
        case .failure(_):
            break
        }
    }
    
    
}
