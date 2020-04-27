//
//  Constants.swift
//  EarthquakeApp
//
//  Created by Prasad Patil on 4/25/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import UIKit

/* Setting all the constants used in different classes and structures*/

class Constants {
    
    // MARK: - Singetons
    static let earthquakeApi : String = "http://api.geonames.org/earthquakesJSON?formatted=true&north=44.1&south=-9.9&east=-22.4&west=55.2&username=mkoppelman"
    static let earthquakeTitle : String = "EARTHQUAKES LIST"
    static let alertTitle : String = "Network Error"
    static let alertMessage : String = "Please turn on wifi/cellular services and restart the app"
    static let ok : String = "OK"
    static let dateFormat : String = "yyyy-MM-dd HH:mm:ss"
    static let dateFormatForTime : String = "h:mm a"
    static let epicenter : String = "Epicenter : "
    static let latitudinalMeters : Double = 1000.0
    static let longitudinalMeters : Double = 1000.0
    static let imageFileName : String = "HighMagnitude"
    static let locationTitle : String = "LOCATION"
    static let leagueGothicRegularFont : String = "LeagueGothic-Regular"
    static let mavenProBoldFont : String = "MavenProBold"
    static let mavenProRegularFont : String = "MavenProRegular"
    static let highMagnitudeQuakeCellIdentifier : String = "HighMagnitudeQuakeCell"
    static let quakeCellIdentifier : String = "QuakeCell"
    static let highMagnitudeQuakeSectionTitle : String = "HIGH MAGNITUDE EARTHQUAKES"
    static let quakeSectionTitle : String = "EARTHQUAKES"
    static let sectionHeaderImage : String = "list_header.png"
    static let sectionFor : String = "Section for "
    static let magnitude : String = "Magnitude : "
    static let date : String = "Date : "
    static let time : String = "Time : "
    static let depth : String = "Depth : "
    static let HighImportanceImage : String = "High"
    static let magnitudeIdentifier : String = "Magnitude"
    static let dateIdentifier : String = "Date"
    static let timeIdentifier : String = "Time"
    static let depthIdentifier : String = "Depth"
    static let back : String = "BACK"
    

    // Accessibility constants
    static let sectionHint : String = "Double Tap to check the epicenter location on map"
    static let magnitudeAccessibility : String = "magnitude of earthquake is "
    static let dateAccessibility : String = "date of earthquake is "
    static let timeAccessibility : String = "time of earthquake is "
    static let depthAccessibility : String = "depth of earthquake is "
    static let HighImportanceImageAccessibility : String = "Marked with High Importance"

}
