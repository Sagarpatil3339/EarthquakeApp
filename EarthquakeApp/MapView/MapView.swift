//
//  MapView.swift
//  EarthquakeApp
//
//  Created by Prasad Patil on 4/25/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIViewController {

    // MARK: - UI Elements(Programatically)

    var map : MKMapView = MKMapView()
    
    var MapViewModel : MapViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.locationTitle
        setupView()
    }
    
    // MARK: - Methods
    
    func setupView(){
        if let MapViewModel = MapViewModel {
            let region = MapViewModel.regionForLocation()
            let annotation = MapViewModel.annotationForLocation()
            self.map.setRegion(region, animated: true)
            self.map.addAnnotation(annotation)
        }
        
        view.addSubview(map)
        setConstraints()
    }
        
    // MARK: - Programatically assigned Constraints

    func setConstraints() {
        map.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            map.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            map.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            map.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
    }
    
}
