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
    func updateMoreRepoInfo(lastCount: Int)
    
    //Interactor
    func didFetchReposData(with result: Result<[RepoTableCellContent], Error>, moreInfo: Bool)
    
}

class SearchUserPresenter {
    
    weak var view: SearchView?
    var router: SearchRouter
    var interactor: SearchInteractor
    
    var repoSearchData: RepoSearchContent?
    
    init(view: SearchView, interactor: SearchInteractor, router: SearchRouter) {
        self.view = view
        self.router = router
        self.interactor = interactor
        
    }
    
}

extension SearchUserPresenter: SearchPresenter {
    
    func searchRepositories(text: String?) {
        
        if let searchText = text, searchText.isNotEmpty {
            repoSearchData = RepoSearchContent(repoName: searchText)
            interactor.getRepositories(repoSearchData!)
        }
    }
    
    func updateMoreRepoInfo(lastCount: Int) {
        
        if repoSearchData != nil && repoSearchData!.isNotFinal {
            repoSearchData?.updatePage(lastCount)
            interactor.getRepositories(repoSearchData!)
        }
    }
    
    func didTappedRepoTableCell(info: RepoTableCellContent) {
        router.showRepoDetailInfoView(data: info)
    }
    
    func didFetchReposData(with result: Result<[RepoTableCellContent], Error>, moreInfo: Bool) {
        
        switch result {
        case .success(let repoListInfo):
            if repoListInfo.isEmpty {
                repoSearchData?.setFinal()
                return
            }
            view?.updateRepoList(list: repoListInfo, moreInfo: moreInfo)
            break
        case .failure(_):
            repoSearchData?.setFinal()
            break
        }
    }
    
    
}
