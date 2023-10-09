//
//  DetailInfoInteractor.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/24.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol DetailInfoInteractor {
    
    func getAvatarImage(url: String)
}

class DetailInfoUserInteractor {
    
    var presenter: DetailInfoPresenter?
    var apiClient: APIClientProtocol?
    
    func setPresenter(presenter: DetailInfoPresenter, apiClient: APIClientProtocol? = WebAPI()) {
        self.presenter = presenter
        self.apiClient = apiClient
    }
    
}

extension DetailInfoUserInteractor: DetailInfoInteractor {
    
    func getAvatarImage(url: String){
            
        apiClient?.getImageData(url: url, completeHandler: { [weak self] (result) in
             
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.presenter?.didFetchImageData(with: .success(data))
                break
            case .failure(let error):
                self.presenter?.didFetchImageData(with: .failure(error))
                break
            }
           
        })
            
    }
}
