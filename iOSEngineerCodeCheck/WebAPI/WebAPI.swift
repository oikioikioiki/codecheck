//
//  WebAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by ふりかけ on R 5/09/24.
//  Copyright © Reiwa 5 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

class WebAPI{
    
    static func searchRepositories(data: SearchRepoRequest, completeHandler: @escaping ([RepoResponse]?, URLResponse?, Error?) -> Void) {

        let info = WebAPIEntity.init(url: "https://api.github.com/search/repositories",
                                     data: data.queryItems,
                                     header: nil,
                                     method: .get)
        
        self.sessionRequest(info: info, completeHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                completeHandler(nil, response, FetchError.noNetwork)
                return
            }
            do{
                let decoder = JSONDecoder()
                let jasonData = try decoder.decode(SearchRepoResponse.self, from: data)
                completeHandler(jasonData.items, response, jasonData.items != nil ? nil : FetchError.noData)
            }catch{
                print("Error : GetUserRepoResponse decodeError")
                completeHandler(nil, response, FetchError.parameter)
            }
        })
    }
    
    static func getImageData(url: String, completeHandler: @escaping (UIImage?, URLResponse?, Error?) -> Void) {
        
        let info = WebAPIEntity.init( url: url,
                                      data: nil,
                                      header: nil,
                                      method: .get)
        
        self.sessionRequest(info: info, completeHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                completeHandler(nil, response, FetchError.noNetwork)
                return
            }
            let image = UIImage(data: data)
            completeHandler(image, response, nil)
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
