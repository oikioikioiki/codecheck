//
//  MockAPIStub.swift
//  iOSEngineerCodeCheckTests
//
//  Created by ふりかけ on R 5/10/09.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck
import UIKit

class MockAPIClient: APIClientProtocol {
    
    var fetchRepoResult: Result<[RepoResponse], FetchError> = .success(mockRepoResponse)
    var fetchImageResult: Result<UIImage, FetchError> = .success(mockImage)
    
    var argument: String?
    
    var resultRepoResponse: [RepoResponse]?
    var resultImage: UIImage?
            
    func searchRepositories(data: SearchRepoRequest, completeHandler: @escaping (Result<[RepoResponse], FetchError>) -> Void) {
        
        completeHandler(fetchRepoResult)
        
        switch fetchRepoResult {
        case .success:
            resultRepoResponse = mockRepoResponse
        default:
            resultRepoResponse = nil
        }
        self.argument = data.repo
    }
    
    func getImageData(url: String, completeHandler: @escaping (Result<UIImage, FetchError>) -> Void) {
        
        completeHandler(fetchImageResult)
        
        switch fetchRepoResult {
        case .success:
            resultImage = mockImage
        default:
            resultImage = nil
        }
        
    }

}

//RepoSearch Test Presenter
class MockSearchPresenter: SearchPresenter {

    var didFetchReposDataCalled = false
    var receivedResult: Result<[RepoTableCellContent], Error>?
    var receivedMoreInfo: Bool?

    func didFetchReposData(with result: Result<[RepoTableCellContent], Error>, moreInfo: Bool) {
        didFetchReposDataCalled = true
        receivedResult = result
        receivedMoreInfo = moreInfo
    }
    
    func searchRepositories(text: String?) {
    }
    
    func didTappedRepoTableCell(info: RepoTableCellContent) {
    }
    
    func updateMoreRepoInfo(lastCount: Int) {
    }
    
    func updateCellData(with result: Result<UIImage, Error>, at: Int) {
    }
}

class MockDetailInfoPresenter: DetailInfoPresenter {
    
    var didFetchImageDataCalled = false
    var fetchedImageDataResult: Result<UIImage, Error>?

    func viewDidLoad(_ data: iOSEngineerCodeCheck.RepoTableCellContent) {
    }
    
    func showWebView(_ data: iOSEngineerCodeCheck.RepoTableCellContent) {
    }
    
    func didFetchImageData(with result: Result<UIImage, Error>) {
        didFetchImageDataCalled = true
        fetchedImageDataResult = result
    }
}
