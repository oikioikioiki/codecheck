//
//  WebInteractor.swift
//  GitHubUsersClientApp
//
//  Created by ふりかけ on R 5/09/26.
//

import Foundation

protocol WebInteractor {
    
}

class WebUserInteractor {
    
    var presenter: WebPresenter?
    
    func setPresenter(presenter: WebPresenter) {
        self.presenter = presenter
    }
    
}

extension WebUserInteractor: WebInteractor {
    
}
