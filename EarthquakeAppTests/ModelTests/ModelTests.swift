//
//  ModelTests.swift
//  EarthquakeAppTests
//
//  Created by Prasad Patil on 4/27/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import XCTest
@testable import EarthquakeApp

class ModelTests: XCTestCase {
    
    @objc class FileClass: NSObject { }
    var data : Data?
    
    // Getting the .json file from the file bundle and converting it in data to test
    override func setUp() {
        let bundle = Bundle(for: FileClass.self)
        if let path = bundle.path(forResource: "Data", ofType: "json") {
            data = try? Data(contentsOf: URL(fileURLWithPath: path))
        }
    }
        
    // To load the data from Mock Json and check the properties
    func testModel() {
        guard let data = data, let dataModel = DataModel(data: data) else {
            XCTFail()
            return
        }
        XCTAssertTrue(dataModel.highMagnitudeQuakes.count == 6)
        XCTAssertTrue(dataModel.quakes.count == 4)
    }
    
}
