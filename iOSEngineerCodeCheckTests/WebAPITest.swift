//
//  WebAPITest.swift
//  iOSEngineerCodeCheckTests
//
//  Created by ふりかけ on R 5/10/09.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class WebAPITest: XCTestCase {
    
    func testGetRepositoriesSuccess() {
        let mockApiClient = MockAPIClient()
        let interactor = SearchUserInteractor()
        let mockPresenter = MockSearchPresenter()

        mockApiClient.fetchRepoResult = .success(mockRepoResponse)
        interactor.setPresenter(presenter: mockPresenter, apiClient: mockApiClient)

        let content = RepoSearchContent(repoName: "testRepo")
        interactor.getRepositories(content)
        
        XCTAssertEqual("testRepo", mockApiClient.argument)
        XCTAssertNotNil(mockPresenter.receivedResult)
        XCTAssertTrue(mockPresenter.didFetchReposDataCalled, "Didn't call didFetchReposData")
        if case .success(let repos) = mockPresenter.receivedResult {
            XCTAssertEqual("Repo 1", repos[0].name)
            XCTAssertEqual(400, repos[3].stars)
        } else {
            XCTFail("Expected success result with repos, but got failure or nil")
        }
    }
    
    func testGetRepositoriesNoNetworkError() {
        testFetchErrorScenario(for: .noNetwork)
    }

    func testGetRepositoriesNoDataError() {
        testFetchErrorScenario(for: .noData)
    }

    func testGetRepositoriesParameterError() {
        testFetchErrorScenario(for: .parameter)
    }
    
    private func testFetchErrorScenario(for error: FetchError) {
        let mockApiClient = MockAPIClient()
        let interactor = SearchUserInteractor()
        let mockPresenter = MockSearchPresenter()

        mockApiClient.fetchRepoResult = .failure(error)
        interactor.setPresenter(presenter: mockPresenter, apiClient: mockApiClient)

        let content = RepoSearchContent(repoName: "testRepo")
        interactor.getRepositories(content)

        XCTAssertEqual("testRepo", mockApiClient.argument)
        XCTAssertTrue(mockPresenter.didFetchReposDataCalled, "Didn't call didFetchReposData for error type: \(error)")
        //エラー確認
        if case .failure(let receivedError as FetchError) = mockPresenter.receivedResult {
            XCTAssertEqual(receivedError, error, "Expected \(error), but received \(receivedError).")
        } else if case .failure(let otherError) = mockPresenter.receivedResult {
            XCTFail("Expected \(error), but received a different type of error: \(otherError).")
        } else {
            XCTFail("Expected \(error), but didn't receive any error.")
        }
    }
    
    func testGetAvatarImageSuccess() {
        let mockApiClient = MockAPIClient()
        let interactor = DetailInfoUserInteractor()
        let mockPresenter = MockDetailInfoPresenter()

        mockApiClient.fetchImageResult = .success(mockImage)
        interactor.setPresenter(presenter: mockPresenter, apiClient: mockApiClient)

        let imageURL = "testURL"
        interactor.getAvatarImage(url: imageURL)

        XCTAssertTrue(mockPresenter.didFetchImageDataCalled, "Didn't call didFetchImageData")
        switch mockPresenter.fetchedImageDataResult {
        case .success(let image):
            XCTAssertNotNil(image, "Image should not be nil")
        default:
            XCTFail("Expected success result")
        }
    }
    
    func testFetchImageNoNetworkError() {
        testFetchImageErrorScenario(for: .noNetwork)
    }

    func testFetchImageNoDataError() {
        testFetchImageErrorScenario(for: .noData)
    }

    private func testFetchImageErrorScenario(for error: FetchError) {
        let mockApiClient = MockAPIClient()
        let interactor = DetailInfoUserInteractor()
        let mockPresenter = MockDetailInfoPresenter()

        mockApiClient.fetchImageResult = .failure(error)
        interactor.setPresenter(presenter: mockPresenter, apiClient: mockApiClient)

        let imageURL = "testURL"
        interactor.getAvatarImage(url: imageURL)

        XCTAssertTrue(mockPresenter.didFetchImageDataCalled, "Didn't call didFetchImageData for \(error) scenario")
        switch mockPresenter.fetchedImageDataResult {
        case .failure(let receivedError):
            XCTAssertEqual(receivedError as? FetchError, error, "Expected \(error) error, but received \(receivedError)")
        default:
            XCTFail("Expected failure result for \(error) scenario")
        }
    }

}
