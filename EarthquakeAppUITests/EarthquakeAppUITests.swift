//
//  EarthquakeAppUITests.swift
//  EarthquakeAppUITests
//
//  Created by Prasad Patil on 4/24/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import XCTest
@testable import EarthquakeApp

class EarthquakeAppUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
    }
    
    // To test number of cells populated on the table
    func testNoOfCells() {
        var countOfCells = 0
        let app = XCUIApplication()
        app.launch()
        for i in 0...app.tables.cells.count-1 {
            app.tables.cells.element(boundBy: i).tap()
            app.navigationBars.buttons["BACK"].tap()
            countOfCells += 1
        }
        XCTAssertTrue(countOfCells == 10)
    }
    
    // To test labels of cells populated on the table
    func testTableCellElements() {
        let app = XCUIApplication()
        app.launch()
        for _ in 0...app.tables.cells.count-1 {
            let magnitude = app.tables.cells.staticTexts["Magnitude"]
            let date = app.tables.cells.staticTexts["Date"]
            let time = app.tables.cells.staticTexts["Time"]
            let depth = app.tables.cells.staticTexts["Depth"]
            XCTAssertTrue(magnitude.exists)
            XCTAssertTrue(date.exists)
            XCTAssertTrue(time.exists)
            XCTAssertTrue(depth.exists)
        }
    }
    
}
