//
//  SearchPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/24.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

protocol SearchPresenter {
    
    //View
    func searchRepositories(text: String?)
    func didTappedRepoTableCell(info: RepoTableCellContent)
    func updateMoreRepoInfo(lastCount: Int)
    
    //Interactor
    func didFetchReposData(with result: Result<[RepoTableCellContent], Error>, moreInfo: Bool)
    func updateCellData(with result: Result<UIImage, Error>, at: Int)
    
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
            view?.showLoadingView()
            repoSearchData = RepoSearchContent(repoName: searchText)
            interactor.getRepositories(repoSearchData!)
        }
    }
    
    func updateMoreRepoInfo(lastCount: Int) {
        
        if repoSearchData != nil && repoSearchData!.isNotFinal && repoSearchData!.isNotLoadingNewElement {
            repoSearchData?.updatePage(lastCount)
            repoSearchData?.setLoading()
            interactor.getRepositories(repoSearchData!)
        }
    }
    
    func didTappedRepoTableCell(info: RepoTableCellContent) {
        router.showRepoDetailInfoView(data: info)
    }
    
    func didFetchReposData(with result: Result<[RepoTableCellContent], Error>, moreInfo: Bool) {
        
        repoSearchData?.setFinishLoading()

        switch result {
        case .success(let repoListInfo):
            if repoListInfo.isEmpty {
                repoSearchData?.setFinal()
                return
            }
            view?.updateRepoList(list: repoListInfo, moreInfo: moreInfo)
            getlistImageData(repoListInfo, repoData: repoSearchData!)
            break
        case .failure(_):
            view?.closeLoading()
            repoSearchData?.setFinal()
            break
        }
    }
    
    func getlistImageData(_ list: [RepoTableCellContent], repoData: RepoSearchContent) {
        print("LastCount : \(repoData.lastListCount)")
        for index in 0..<list.count {
            let element = list[index]
            interactor.updateDataImage(url: element.avatarImageURL ?? "", at: repoData.lastListCount + index)
        }
    }
    
    func updateCellData(with result: Result<UIImage, Error>, at: Int) {

        switch result {
        case .success(let image):
            view?.updateImageData(image: image, at: at)
            break
        case .failure(_):
            break
        }
        
        
    }
    
    
}
