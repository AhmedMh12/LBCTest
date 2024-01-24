//
//  ListCategoriesViewModelTests.swift
//  LBCTechnicalTestTests
//
//  Created by Ahmed on 24/01/2024.
//

import XCTest
@testable import LBCTechnicalTest

class ListCategoriesViewModelTests: XCTestCase {
    
    var viewModel: ListCategoriesViewModel!
    var mockAPICaller: MockAPICaller!
    
    override func setUp() {
        super.setUp()
        mockAPICaller = MockAPICaller()
        viewModel = ListCategoriesViewModel()
        viewModel.isLoadingData = Observable(false)
        viewModel.dataSource = nil
    }
    
    override func tearDown() {
        mockAPICaller = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testGetDataSuccess() {
        // Assuming you have a sample categoriesData
        let sampleCategoriesData: [ProductCategory] = [ProductCategory(id: 1, name: "category1"), ProductCategory(id: 1, name: "category2")]
        
        // Set the mock APICaller to return success
        mockAPICaller.shouldSucceed = true
        mockAPICaller.categoriesData = sampleCategoriesData
        
        viewModel.getData()
        
        // Assert that isLoadingData is set to true during the API call
        XCTAssertTrue(viewModel.isLoadingData.value ?? false)
        
        // Simulate API success
        mockAPICaller.catrgeoriesCompletion?(.success(sampleCategoriesData))
    }
    
    func testGetDataFailure() {
        // Set the mock APICaller to return failure
        mockAPICaller.shouldSucceed = false
        
        viewModel.getData()
        
        // Assert that isLoadingData is set to true during the API call
        XCTAssertTrue(viewModel.isLoadingData.value ?? false)
        
        // Simulate API failure
        mockAPICaller.completion?(.failure(MockError.mockError))
        
    }
}


