//
//  DetailInfoPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/24.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

protocol DetailInfoPresenter {
    
    //View
    func viewDidLoad(_ data: RepoTableCellContent)
    func showWebView(_ data: RepoTableCellContent)
    
    //Interactor
    func didFetchImageData(with result: Result<UIImage, Error>)
    
}

class DetailInfoUserPresenter {
    
    weak var view: DetailInfoView?
    var router: DetailInfoRouter
    var interactor: DetailInfoInteractor
    
    init(view: DetailInfoView, interactor: DetailInfoInteractor, router: DetailInfoRouter) {
        self.view = view
        self.router = router
        self.interactor = interactor
        
    }
    
}

extension DetailInfoUserPresenter: DetailInfoPresenter {
    
    func viewDidLoad(_ data: RepoTableCellContent) {
        
        if let imageURL = data.avatarImageURL {
            interactor.getAvatarImage(url: imageURL)
        }
    }
    
    func didFetchImageData(with result: Result<UIImage, Error>) {
        
        switch result {
        case .success(let image):
            view?.showAvatarImage(image: image)
            break
        case .failure(_):
            break
        }
    }
    
    func showWebView(_ data: RepoTableCellContent) {
        router.presentWebVIew(info: data)
    }
    
    
}
