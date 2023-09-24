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
    
    func setPresenter(presenter: DetailInfoPresenter) {
        self.presenter = presenter
    }
    
}

extension DetailInfoUserInteractor: DetailInfoInteractor {
    
    func getAvatarImage(url: String){
            
        WebAPI.getImageData(url: url, completeHandler: { [weak self] (data, response, error) in
             
            guard let self = self else { return }
            guard let data = data, error == nil else {
                self.presenter?.didFetchImageData(with: .failure(error as! FetchError))
                return
            }
            
            self.presenter?.didFetchImageData(with: .success(data))
           
        })
            
    }
}
