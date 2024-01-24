//
//  ListProductsUITests.swift
//  LBCTechnicalTestUITests
//
//  Created by Ahmed on 24/01/2024.
//

import XCTest

class ListProductsUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testFilterButton() {
        // Assuming you are on the ListProductsViewController
        
        // Tap on the filter button
        app.navigationBars.buttons["filter"].tap()
        
        // Assuming you navigate to the ListCategoriesViewController
        let backButton = app.navigationBars.buttons["Annuler"]
        
        // Verify the navigation to the ListCategoriesViewController
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
        
        // Go back to ListProductsViewController
        backButton.tap()
    }

    func testSelectProduct() {
        // Assuming you are on the ListProductsViewController
        
        // Tap on the first cell
        let firstCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        firstCell.tap()
    }
}
