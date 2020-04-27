//
//  MapViewModel.swift
//  EarthquakeApp
//
//  Created by Prasad Patil on 4/25/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import Foundation
import MapKit

class MapViewModel : NSObject {
    
    // MARK: - Properties
    
    var longitude : Double = 0.0
    var latitude : Double = 0.0
    var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    init(set: Earthquakes) {
        super.init()
        if let longitude = set.longitude, let latitude = set.latitude {
            self.longitude = longitude
            self.latitude = latitude
        }
        center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // MARK: - Methods
    
    // For getting region coordinates inorder to set the region for MKMapView
    func regionForLocation() -> MKCoordinateRegion {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: Constants.latitudinalMeters, longitudinalMeters: Constants.longitudinalMeters)
        return region
    }
    
    // For creating annotation object and setting coordinates based on longitude and latitude
    // Also setting accessibility for annotation object
    func annotationForLocation() -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.isAccessibilityElement = true
        reverseLocation() { locationName in
            annotation.title = Constants.epicenter + (locationName)
            annotation.accessibilityLabel = Constants.epicenter + (locationName)
        }
        return annotation
    }
    
    
    // For Getting location data (eg:- name of place, country, etc..) from longitude and latitude
    func reverseLocation(completionHandler: @escaping (_ location : String) -> ()) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        var placemark: CLPlacemark?
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                print(error ?? "Error in finding location name")
            }
            
            if let placemarks = placemarks {
                placemark = placemarks.first
                if let location = placemark?.name {
                    let complete_location = ((placemark?.country) != nil) ? "\(location)" + ", \(placemark?.country ?? "")" : "\(location)"
                    completionHandler(complete_location)
                }
            }
        }
    }
}
