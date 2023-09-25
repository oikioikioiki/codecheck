//
//  WebPresenter.swift
//  GitHubUsersClientApp
//
//  Created by ふりかけ on R 5/09/26.
//

import Foundation

protocol WebPresenter {
    
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

class WebUserPresenter {
    
    weak var view: WebView?
    var router: WebRouter
    var interactor: WebInteractor
    
    init(view: WebView, interactor: WebInteractor, router: WebRouter) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension WebUserPresenter: WebPresenter {
    
    func viewDidLoad() {
        view?.updateWebView()
    }
    
    func viewWillAppear() {
        view?.reloadWebView()
    }
        
    func viewWillDisappear() {
        view?.stopWebView()
    }
}
