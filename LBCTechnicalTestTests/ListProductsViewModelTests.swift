//
//  ListProductsViewModelTests.swift
//  LBCTechnicalTestTests
//
//  Created by Ahmed on 24/01/2024.
//

import XCTest
@testable import LBCTechnicalTest

class ListProductsViewModelTests: XCTestCase {
    
    var viewModel: ListProductsViewModel!
    var mockAPICaller: MockAPICaller!
        
        override func setUp() {
            super.setUp()
            mockAPICaller = MockAPICaller()
            viewModel = ListProductsViewModel()
            viewModel.isLoadingData = Observable(false)
            viewModel.dataSource = nil
        }
    
    
    override func tearDown() {
            mockAPICaller = nil
            viewModel = nil
            super.tearDown()
        }
        
        func testGetDataSuccess() {
            let sampleProductsData: [Product] = [
                Product(id: 1, category_id: 1, title: "Product 1",description: "item 1", price: 10, creation_date: "2022-01-23T12:00:00Z", is_urgent: false),
                Product(id: 2, category_id: 1, title: "Product 2",description: "item 2", price: 10, creation_date: "2022-01-24T12:00:00Z", is_urgent: false),
                Product(id: 3, category_id: 1, title: "Product 3",description: "item 3", price: 10, creation_date: "2022-01-22T12:00:00Z", is_urgent: false)
            ]
            
            // Set the mock APICaller to return success
            mockAPICaller.shouldSucceed = true
            mockAPICaller.productsData = sampleProductsData
            
            viewModel.getData()
            
            // Assert that isLoadingData is set to true during the API call
            XCTAssertTrue(viewModel.isLoadingData.value ?? false)
            
            // Simulate API success
            mockAPICaller.completion?(.success(sampleProductsData))
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
    
    func testNumberOfSections() {
        XCTAssertEqual(viewModel.numberOfSections(), 1)
    }
    
    func testNumberOfRows() {
        // Assuming dataSource is nil initially
        XCTAssertEqual(viewModel.numberOfRows(in: 0), 0)
        
        viewModel.dataSource = [Product(id: 1, category_id: 1, title: "Product 1",description: "item 1", price: 10, creation_date: "2022-01-23T12:00:00Z", is_urgent: false)]
        XCTAssertEqual(viewModel.numberOfRows(in: 0), 1)
    }
    
    
    func testSortProductByDate() {
        let unsortedProducts = [
            Product(id: 1, category_id: 1, title: "Product 1",description: "item 1", price: 10, creation_date: "2022-01-23T12:00:00Z", is_urgent: false),
            Product(id: 2, category_id: 1, title: "Product 2",description: "item 2", price: 10, creation_date: "2022-01-24T12:00:00Z", is_urgent: false),
            Product(id: 3, category_id: 1, title: "Product 3",description: "item 3", price: 10, creation_date: "2022-01-22T12:00:00Z", is_urgent: false)
        ]
        
        // Sorting the products
        let sortedProducts = viewModel.sortProductByDate(products: unsortedProducts)
        
        // Asserting the order of sorted products
        XCTAssertEqual(sortedProducts.map { $0.id }, [2, 1, 3])
    }
}

