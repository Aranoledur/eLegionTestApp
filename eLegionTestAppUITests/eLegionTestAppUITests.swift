//
//  eLegionTestAppUITests.swift
//  eLegionTestAppUITests
//
//  Created by Nikolay Ischuk on 19.07.16.
//  Copyright © 2016 Nikolay Ischuk. All rights reserved.
//

import XCTest

class eLegionTestAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        
        let tablesQuery = app.tables
        let cells = tablesQuery.childrenMatchingType(.Cell)
        var oldCellsCount = cells.count

        app.navigationBars["Repositories"].buttons["Search"].tap()
        
        let exists = NSPredicate(format: "count == 0")
        expectationForPredicate(exists, evaluatedWithObject: cells, handler: nil)
        waitForExpectationsWithTimeout(5, handler: nil)

        app.tables.searchFields["Search"].tap()
        app.searchFields["Search"]
        app.typeText("Swift\r")
        
        cells.elementBoundByIndex(0).tap()
        let repoCell = tablesQuery.childrenMatchingType(.Cell).elementBoundByIndex(2)
        if !repoCell.selected {
            repoCell.tap()
        } else {
            oldCellsCount -= 1
        }
        repoCell.tap()
        repoCell.tap()
        let repoLabel = repoCell.staticTexts.elementBoundByIndex(0).label
        XCUIApplication().navigationBars["Search"].buttons["Repositories"].tap()
        let newCellsCount = cells.count
        
        XCTAssertEqual(app.tables.count, 1)
        XCTAssert(tablesQuery.staticTexts[repoLabel].exists && newCellsCount == oldCellsCount + 1, "cached cell not exist")
    }
    
}
