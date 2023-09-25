//
//  DetailInfoRouter.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/24.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation

import UIKit

protocol DetailInfoRouter {
    
    func presentWebVIew(info: RepoTableCellContent)
}

class DetailInfoUserRouter {
    
    weak var viewController: UIViewController?
    var presenter: DetailInfoPresenter?
    
    func setPresenter(presenter: DetailInfoPresenter) {
        self.presenter = presenter
    }
    
    init(viewController: UIViewController){
        self.viewController = viewController
    }
    
    static func create(view: DetailInfoViewController) {
        
        let interactor = DetailInfoUserInteractor()
        let router = DetailInfoUserRouter(viewController: view)
        let presenter = DetailInfoUserPresenter(view: view, interactor: interactor, router: router)
        interactor.setPresenter(presenter: presenter)
        router.setPresenter(presenter: presenter)
        view.setPresenter(presenter: presenter)
    }
    
}

extension DetailInfoUserRouter: DetailInfoRouter {
    
    func presentWebVIew(info: RepoTableCellContent) {
        
        DispatchQueue.main.async {
            let vc = WebViewController(URL(string: info.htmlURL)!)
            self.viewController?.present(vc, animated: true)
        }
    }
    
}
