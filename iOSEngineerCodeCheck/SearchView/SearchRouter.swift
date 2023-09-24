//
//  SearchRouter.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/24.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

protocol SearchRouter {
    
    func showRepoDetailInfoView(data: RepoTableCellContent)
}

class SearchUserRouter {
    
    weak var viewController: UIViewController?
    var presenter: SearchPresenter?
    
    func setPresenter(presenter: SearchPresenter) {
        self.presenter = presenter
    }
    
    init(viewController: UIViewController){
        self.viewController = viewController
    }
    
    static func create(view: SearchViewController) {
        
        let interactor = SearchUserInteractor()
        let router = SearchUserRouter(viewController: view)
        let presenter = SearchUserPresenter(view: view, interactor: interactor, router: router)
        interactor.setPresenter(presenter: presenter)
        router.setPresenter(presenter: presenter)
        view.setPresenter(presenter: presenter)
    }
    
}

extension SearchUserRouter: SearchRouter {
    
    func showRepoDetailInfoView(data: RepoTableCellContent) {
        DispatchQueue.main.async {
            let detailView = DetailInfoViewController(data)
            self.viewController?.navigationController?.pushViewController(detailView, animated: true)
        }
    }
    
}
