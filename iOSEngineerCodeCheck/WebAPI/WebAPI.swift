//
//  WebAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/24.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

protocol APIClientProtocol {
    
    func searchRepositories(data: SearchRepoRequest, completeHandler: @escaping (Result<[RepoResponse], FetchError>) -> Void)
    func getImageData(url: String, completeHandler: @escaping (Result<UIImage, FetchError>) -> Void)
}

class WebAPI: APIClientProtocol {
    
    func searchRepositories(data: SearchRepoRequest, completeHandler: @escaping (Result<[RepoResponse], FetchError>) -> Void) {

        let info = WebAPIEntity.init(url: "https://api.github.com/search/repositories",
                                     data: data.queryItems,
                                     header: nil,
                                     method: .get)
        
        WebAPI.sessionRequest(info: info, completeHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                completeHandler(.failure(.noNetwork))
                return
            }
            do{
                let decoder = JSONDecoder()
                let jasonData = try decoder.decode(SearchRepoResponse.self, from: data)
                if let items = jasonData.items {
                    completeHandler(.success(items))
                } else {
                    completeHandler(.failure(.noData))
                }
            }catch{
                print("Error : GetUserRepoResponse decodeError")
                completeHandler(.failure(.parameter))
            }
        })
    }
    
    func getImageData(url: String, completeHandler: @escaping (Result<UIImage, FetchError>) -> Void) {
        
        let info = WebAPIEntity.init( url: url,
                                      data: nil,
                                      header: nil,
                                      method: .get)
        
        WebAPI.sessionRequest(info: info, completeHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                completeHandler(.failure(.noNetwork))
                return
            }
            if let image = UIImage(data: data) {
                completeHandler(.success(image))
            } else {
                completeHandler(.failure(.noData))
            }
        })
        
    }
    
    static func sessionRequest(info: WebAPIEntity, completeHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        var urlComponents = URLComponents(string: info.url)!
        
        if (info.method == .get) {
            urlComponents.queryItems = info.data as? [URLQueryItem]
        }
        
        let url = urlComponents.url!
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = info.method.data
        
        if (info.method == .post) {
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: info.data!, options: .prettyPrinted)
                request.httpBody = jsonData
            }catch{
                fatalError("Unable To Convert in Json")
            }
        }
        
        if info.header != nil {
            for (key, value) in info.header! {
                request.addValue("\(value)", forHTTPHeaderField: "\(key)")
            }
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            completeHandler(data, response, error)
        })
        task.resume()
    }
    
}
