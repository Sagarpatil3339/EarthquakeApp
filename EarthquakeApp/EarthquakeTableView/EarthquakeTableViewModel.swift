//
//  EarthquakeTableViewModel.swift
//  EarthquakeApp
//
//  Created by Prasad Patil on 4/25/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import Foundation
import UIKit

/* Have used Factory Design pattern for managing diferent type of sections based on data */

// Type of sections in tableViews

enum Type {
    case HighMagnitudeQuake
    case Quake
}

// In order to enclose each structure in Sections(as BaseClass) and adding important parameters for different sections

protocol Section {
    var type: Type { get }
    var title: String { get }
    var sectionCount: Int { get }
}

class EarthquakeTableViewModel: NSObject {
    // MARK: - Properties
    
    var items = [Section]()
    
    private var dataService: DataService?
    
    init(dataService: DataService) {
        super.init()
        self.dataService = dataService
    }

    // MARK: - Methods

    // Initial network call for fetching json and modeling
    // Managing the data of each earthquake in diferent structures and then in sections
    
    func networkCall(completionHandler: @escaping (_ refresh : Bool) -> ()) {
        
        let endPoint : String = Constants.earthquakeApi
        
        guard  let endpointUrl = URL(string: endPoint) else {
            return;
        }
        let request = URLRequest(url: endpointUrl);
        
        self.dataService?.httpResponse(request: request) { (received_data, error) in
            
            if let error = error {
                print(error)
                completionHandler(false)
            }
            
            guard let successData = received_data, let dataModel = DataModel(data: successData) else{
                return
            }
            let highMagnitudeQuakes = dataModel.highMagnitudeQuakes
            if !highMagnitudeQuakes.isEmpty {
                let highMagnitudeQuakesItems = HighMagnitudeQuakeSection(highMagnitudeQuakes: highMagnitudeQuakes)
                self.items.append(highMagnitudeQuakesItems)
            }
            
            let quakes = dataModel.quakes
            if !quakes.isEmpty {
                let quakesItems = QuakeSection(quakes: quakes)
                self.items.append(quakesItems)
            }
                        
            completionHandler(true);
        }
    }
}

// MARK: - Section Classes

class HighMagnitudeQuakeSection: Section {
    var type: Type {
        return .HighMagnitudeQuake
    }
    
    var title: String {
        return Constants.highMagnitudeQuakeSectionTitle
    }
    
    var sectionCount: Int {
        return highMagnitudeQuakes.count
    }
    
    var highMagnitudeQuakes: [Earthquakes]
    
    init(highMagnitudeQuakes: [Earthquakes]) {
        self.highMagnitudeQuakes = highMagnitudeQuakes
    }
}

class QuakeSection: Section {
    var type: Type {
        return .Quake
    }
    
    var title: String {
        return Constants.quakeSectionTitle
    }
    
    var sectionCount: Int {
        return quakes.count
    }
    
    var quakes: [Earthquakes]
    
    init(quakes: [Earthquakes]) {
        self.quakes = quakes
    }
}


// MARK: - Table datasource protocal stubs

extension EarthquakeTableViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].sectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .HighMagnitudeQuake:
            if let item = item as? HighMagnitudeQuakeSection, let cell = tableView.dequeueReusableCell(withIdentifier: Constants.highMagnitudeQuakeCellIdentifier, for: indexPath) as? HighMagnitudeQuakeCell {
                cell.item = item.highMagnitudeQuakes[indexPath.row]
                return cell
            }
        case .Quake:
            if let item = item as? QuakeSection, let cell = tableView.dequeueReusableCell(withIdentifier: Constants.quakeCellIdentifier, for: indexPath) as? QuakeCell {
                cell.item = item.quakes[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].title
    }
}
