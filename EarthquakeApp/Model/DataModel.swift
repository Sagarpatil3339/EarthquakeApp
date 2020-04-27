//
//  DataModel.swift
//  EarthquakeApp
//
//  Created by Prasad Patil on 4/25/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

/* Modelling JSON data into structures using CODABLE and setting them into arrays for different Sections*/

import Foundation

class DataModel {
    var highMagnitudeQuakes = [Earthquakes]()
    var quakes = [Earthquakes]()
    
    init?(data: Data) {
        do {
            let response = try JSONDecoder().decode(EarthquakesSet.self, from: data)
            for each in response.earthquakes {
                if let magnitude = each.magnitude {
                if magnitude >= 8.0 {
                    highMagnitudeQuakes.append(each)
                } else {
                    quakes.append(each)
                }
                }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
            return nil
        }
    }
}
