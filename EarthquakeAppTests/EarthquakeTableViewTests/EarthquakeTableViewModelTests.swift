//
//  EarthquakeTableViewModelTests.swift
//  EarthquakeAppTests
//
//  Created by Prasad Patil on 4/27/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import XCTest
@testable import EarthquakeApp

class EarthquakeTableViewModelTests: XCTestCase {
    
    var viewModel : EarthquakeTableViewModel?
    
    override func setUp() {
        viewModel = EarthquakeTableViewModel(dataService: DataService())
    }
    
    // To Test the netwrk call and properties loaded in the ViewModel after successfull response and data
    func testNetworkCallAndProperties() {
        guard let viewModel = viewModel else {
            XCTFail()
            return
        }
        
        let exp = expectation(description: "ViewModel Loading")
        
        viewModel.networkCall() { (value)  in
            if value {
                exp.fulfill()
            } else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 3)
        
        XCTAssertTrue(viewModel.items.count == 2)
        
        for item in viewModel.items {
            if let item = item as? HighMagnitudeQuakeSection {
                XCTAssertTrue(item.sectionCount == 6)
                XCTAssertTrue(item.type == .HighMagnitudeQuake)
            }
            if let item = item as? QuakeSection {
                XCTAssertTrue(item.sectionCount == 4)
                XCTAssertTrue(item.type == .Quake)
            }
        }
        
        
    }
    
    // To Test Failure of network call to fetch data due to network absence
    // Turn your wifi/cellular network inorder to pass the test
    func testNetworkCallFail() {
        
        guard let viewModel = viewModel else {
            XCTFail()
            return
        }
        
        let exp = expectation(description: "Network call fails")
        
        viewModel.networkCall() { (value)  in
            if value {
                XCTFail()
            } else {
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3)
        
    }
    
}
