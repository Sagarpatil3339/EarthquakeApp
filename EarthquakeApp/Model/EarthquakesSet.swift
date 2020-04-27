//
//  ResponseSet.swift
//  EarthquakeApp
//
//  Created by Prasad Patil on 4/25/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

/* Structuring data for each instace of JSON Array with CODABLE Protocal*/

import UIKit

struct EarthquakesSet : Codable {
    var earthquakes : [Earthquakes]
}

struct Earthquakes : Codable {
    var datetime : String?
    var depth : Double?
    var longitude : Double?
    var src : String?
    var eqid : String?
    var magnitude : Double?
    var latitude : Double?
    
    enum CodingKeys: String, CodingKey {
        case datetime
        case depth
        case longitude = "lng"
        case src
        case eqid
        case magnitude
        case latitude = "lat"
    }
    
}
