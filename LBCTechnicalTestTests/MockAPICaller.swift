//
//  MockAPICaller.swift
//  LBCTechnicalTestTests
//
//  Created by Ahmed on 24/01/2024.
//
import XCTest
@testable import LBCTechnicalTest

class MockAPICaller: APICaller {
    var shouldSucceed: Bool = true
    var productsData: [Product]?
    var completion: ((Result<[Product], Error>) -> Void)?
    var categoriesData: [ProductCategory]?
    var catrgeoriesCompletion: ((Result<[ProductCategory], Error>) -> Void)?
    
    func getLBCProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        self.completion = completion
        if shouldSucceed {
            completion(.success(productsData ?? []))
        } else {
            completion(.failure(MockError.mockError))
        }
    }
        
    
    func getLBCCategories(completion: @escaping (Result<[ProductCategory], Error>) -> Void) {
        self.catrgeoriesCompletion = completion
        if shouldSucceed {
            completion(.success(categoriesData ?? []))
        } else {
            completion(.failure(MockError.mockError))
        }
    }
}

// Define a mock error for testing
enum MockError: Error {
    case mockError
}
