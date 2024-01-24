//
//  ListCategoriesUITests.swift
//  LBCTechnicalTestUITests
//
//  Created by Ahmed on 24/01/2024.
//

import XCTest

class ListCategoriesUITests: XCTestCase {
    
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

    func testSelectCategory() {
        // Assuming you have launched your app and on the ListCategoriesViewController
        
        // Assuming there is at least one cell visible
        let firstCell = app.tables.cells.element(boundBy: 0)
        
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        
        // Tap on the first cell
        firstCell.tap()
    }
}
