//
//  APICaller.swift
//  LBCTechnicalTest
//
//  Created by Ahmed on 21/01/2024.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class APICaller {
    
    static func getLBCProducts(completionHandler: @escaping (_ result: Result<[Product], NetworkError>) -> Void) {
    
        
        let urlString = NetworkConstants.shared.serverAddress +
                "listing.json"
                
        guard let url = URL(string: urlString) else {
            completionHandler(Result.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode([Product].self, from: data) {
                completionHandler(.success(resultData))
            } else {
                print(err.debugDescription)
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    
    static func getLBCCategories(completionHandler: @escaping (_ result: Result<[ProductCategory], NetworkError>) -> Void) {
    
        
        let urlString = NetworkConstants.shared.serverAddress +
                "categories.json"
                
        guard let url = URL(string: urlString) else {
            completionHandler(Result.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode([ProductCategory].self, from: data) {
                completionHandler(.success(resultData))
            } else {
                print(err.debugDescription)
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
}

