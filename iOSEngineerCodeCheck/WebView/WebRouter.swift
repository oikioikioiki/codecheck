//
//  WebRouter.swift
//  GitHubUsersClientApp
//
//  Created by ふりかけ on R 5/09/26.
//

import Foundation
import UIKit

protocol WebRouter {
    
}

class WebUserRouter {
    
    weak var viewController: UIViewController?
    var presenter: WebPresenter?
    
    func setPresenter(presenter: WebPresenter) {
        self.presenter = presenter
    }
    
    init(viewController: UIViewController){
        self.viewController = viewController
    }
    
    static func create(view: WebViewController) {
        
        let interactor = WebUserInteractor()
        let router = WebUserRouter(viewController: view)
        let presenter = WebUserPresenter(view: view, interactor: interactor, router: router)
        interactor.setPresenter(presenter: presenter)
        router.setPresenter(presenter: presenter)
        view.setPresenter(presenter: presenter)
        
    }
    
}

extension WebUserRouter: WebRouter {
    
}
