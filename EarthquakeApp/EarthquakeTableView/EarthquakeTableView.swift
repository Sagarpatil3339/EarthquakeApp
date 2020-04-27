//
//  EarthquakeTableView.swift
//  EarthquakeApp
//
//  Created by Prasad Patil on 4/25/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import UIKit

class EarthquakeTableView: UIViewController {
    
    // MARK: - UI Elements(Programatically)
    
    let table : UITableView = {
        let tableview = UITableView()
        tableview.separatorColor = UIColor.darkText
        return tableview
    }()
    
    let viewModel = EarthquakeTableViewModel(dataService: DataService())
    
    override func viewDidLoad() {
        setTitles()
        super.viewDidLoad()
        viewModel.networkCall() { (refresh)  in
            if refresh {
                self.updateUI()
            } else {
                AlertView.configureAlert(viewController: self)
            }
        }
        setTable()
        setView()
    }
    
    // MARK: - Methods
    
    func setTitles() {
        title = Constants.earthquakeTitle
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: Constants.back, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.accessibilityIdentifier = Constants.back
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.table.reloadData();
        }
    }
    
    func setTable() {
        table.dataSource = viewModel
        table.delegate = self
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        table.register(HighMagnitudeQuakeCell.self, forCellReuseIdentifier: Constants.highMagnitudeQuakeCellIdentifier)
        table.register(QuakeCell.self, forCellReuseIdentifier: Constants.quakeCellIdentifier)
    }
    
    
    func setView(){
        view.addSubview(table)
        setConstraints()
    }
    
    // For refreshing data with different orientation of the screen
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { context in
            if UIApplication.shared.statusBarOrientation.isLandscape {
                self.table.reloadData()
            } else {
                self.table.reloadData()
            }
        })
    }
    
    // MARK: - Programatically assigned Constraints
    
    func setConstraints() {
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            table.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            table.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - Table Delegate protocal stubs

extension EarthquakeTableView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let MapViewController = MapView()
        let item = viewModel.items[indexPath.section]
        switch item.type {
        case .HighMagnitudeQuake:
            if let item = item as? HighMagnitudeQuakeSection{
                MapViewController.MapViewModel = MapViewModel(set: item.highMagnitudeQuakes[indexPath.row])
            }
            
        case .Quake:
            if let item = item as? QuakeSection{
                MapViewController.MapViewModel = MapViewModel(set: item.quakes[indexPath.row])
            }
        }
        navigationController?.pushViewController(MapViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        let label = UILabel(frame: CGRect(x: 0, y: 14, width: tableView.frame.size.width, height: 32))
        CustomUIElement.forLabel(sender: label, name: Constants.mavenProBoldFont, size: 20, textColor: UIColor.red, textAlignment: .center)
        label.text = viewModel.items[section].title
        label.isAccessibilityElement = true
        if let accessibilityText = label.text {
            label.accessibilityLabel = Constants.sectionFor + (accessibilityText)
            label.accessibilityHint = Constants.sectionHint
        }
        if let image = UIImage(named: Constants.sectionHeaderImage) {
            view.backgroundColor = UIColor(patternImage: image)
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
}
