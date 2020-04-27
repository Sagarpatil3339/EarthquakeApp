//
//  MapViewModelTests.swift
//  EarthquakeAppTests
//
//  Created by Prasad Patil on 4/27/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import XCTest
@testable import EarthquakeApp

class MapViewModelTests: XCTestCase {
    
    let item : Earthquakes = Earthquakes(longitude: -5.796, latitude: -75.2975)
    var mapViewModel : MapViewModel?
    override func setUp() {
        mapViewModel =  MapViewModel(set: item)
    }
    
    // To test fetching of location based on the loading of properties in viewModel when passed data in terms of longitude and latitude.
    func testGetLocation() {
        guard let viewModel = mapViewModel else {
            XCTFail()
            return
        }
        let exp = expectation(description: "Location Retreiving")
        
        XCTAssertNotNil(viewModel.latitude)
        XCTAssertNotNil(viewModel.longitude)
        
        viewModel.reverseLocation() { locationName in
            if !locationName.isEmpty
            {
                exp.fulfill()
            } else {
                XCTFail()
            }
        }
        waitForExpectations(timeout: 3)
    }
    
}
