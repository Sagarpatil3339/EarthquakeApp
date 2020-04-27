//
//  QuakeCell.swift
//  EarthquakeApp
//
//  Created by Prasad Patil on 4/25/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import UIKit

class QuakeCell: UITableViewCell {
    
    // MARK: - UI Elements(Programatically)
    
    var magnitude : UILabel = {
        let label = UILabel()
        CustomUIElement.forLabel(sender: label, name: Constants.leagueGothicRegularFont, size: 40,textColor: .white, textAlignment: .center)
        return label
    }()
    
    var date : UILabel = {
        let label = UILabel()
        CustomUIElement.forLabel(sender: label, name: Constants.leagueGothicRegularFont, size: 20,textColor: .white, textAlignment: .left)
        return label
    }()
    
    var time : UILabel = {
        let label = UILabel()
        CustomUIElement.forLabel(sender: label, name: Constants.leagueGothicRegularFont, size: 20,textColor: .white, textAlignment: .left)
        return label
    }()
    
    var depth : UILabel = {
        let label = UILabel()
        CustomUIElement.forLabel(sender: label, name: Constants.leagueGothicRegularFont, size: 20,textColor: .white, textAlignment: .left)
        return label
    }()
    
    // Constraints for size classes
    var timeWidthConstraint : NSLayoutConstraint = NSLayoutConstraint()
    var dateWidthConstraint : NSLayoutConstraint = NSLayoutConstraint()
    var depthWidthConstraint : NSLayoutConstraint = NSLayoutConstraint()

    // Setting data from each structure to assign properties to each element of each cell

    var item: Earthquakes? {
        didSet {
            guard let item = item else {
                return
            }
            if let magnitudeValue = item.magnitude {
                self.magnitude.text = "\(Constants.magnitude)\(magnitudeValue)"
                self.magnitude.accessibilityLabel = "\(Constants.magnitudeAccessibility)\(magnitudeValue)"
            }
            if let timestamp = item.datetime
            {
                let dateTimeObject = DateTimeExtractor(Timestamp: timestamp)
                self.date.text = "\(Constants.date)\(dateTimeObject.date)"
                self.time.text = "\(Constants.time)\(dateTimeObject.time)"
                self.date.accessibilityLabel = "\(Constants.dateAccessibility)\(dateTimeObject.date)"
                self.time.accessibilityLabel = "\(Constants.timeAccessibility)\(dateTimeObject.time)"
            }
            if let depth = item.depth
            {
                self.depth.text = "\(Constants.depth)\(depth)"
                self.depth.accessibilityLabel = "\(Constants.depthAccessibility)\(depth)"
                
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.isAccessibilityElement = false
        self.shouldGroupAccessibilityChildren = true
        setupView()
        setupAccesibilityIdentifiers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setupView() {
        backgroundColor = .lightGray
        addSubview(magnitude)
        addSubview(date)
        addSubview(time)
        addSubview(depth)
        setConstraints()
    }

    func setupAccesibilityIdentifiers() {
        self.magnitude.accessibilityIdentifier = Constants.magnitudeIdentifier
        self.date.accessibilityIdentifier = Constants.dateIdentifier
        self.time.accessibilityIdentifier = Constants.timeIdentifier
        self.depth.accessibilityIdentifier = Constants.depthIdentifier
    }
    
    // MARK: - Programatically assigned Constraints

    func setConstraints() {
        magnitude.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        time.translatesAutoresizingMaskIntoConstraints = false
        depth.translatesAutoresizingMaskIntoConstraints = false
        
        if UIApplication.shared.statusBarOrientation.isLandscape {
            timeWidthConstraint = time.widthAnchor.constraint(equalToConstant: 280)
            dateWidthConstraint = date.widthAnchor.constraint(equalToConstant: 280)
            depthWidthConstraint = depth.widthAnchor.constraint(equalToConstant: 280)
        } else {
            timeWidthConstraint = time.widthAnchor.constraint(equalToConstant: 150)
            dateWidthConstraint = date.widthAnchor.constraint(equalToConstant: 140)
            depthWidthConstraint = depth.widthAnchor.constraint(equalToConstant: 150)
        }
        
        // For Creating and Activating different constraints
        NSLayoutConstraint.activate([
            magnitude.centerXAnchor.constraint(equalTo: centerXAnchor),
            magnitude.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            magnitude.widthAnchor.constraint(equalToConstant: 200),
            
            time.topAnchor.constraint(equalTo: magnitude.bottomAnchor, constant: 15),
            time.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timeWidthConstraint,
            
            date.topAnchor.constraint(equalTo: magnitude.bottomAnchor, constant: 15),
            date.leadingAnchor.constraint(equalTo: time.trailingAnchor, constant: 5),
            dateWidthConstraint,
            
            depth.topAnchor.constraint(equalTo: time.bottomAnchor, constant: 10),
            depth.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            depth.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            depthWidthConstraint
        ])
    }
}

/* For Different device sizes and different orientations : - Change in constraint values depending on Size classes
*/
extension QuakeCell {
        
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.regular, .regular):
            setupRegularRegular()
            
        case (.compact, .compact):
            setupCompactCompact()
            
        case (.regular, .compact):
            setupRegularCompact()
            
        case (.compact, .regular):
            setupCompactRegular()
            
        default: break
        }
        
    }
    
    func setupRegularRegular() {
        timeWidthConstraint.constant = 280
        dateWidthConstraint.constant = 280
        dateWidthConstraint.constant = 280
        layoutIfNeeded()
    }
    
    func setupCompactCompact() {
        timeWidthConstraint.constant = 280
        dateWidthConstraint.constant = 280
        dateWidthConstraint.constant = 280
        layoutIfNeeded()
    }
    
    func setupCompactRegular() {
        timeWidthConstraint.constant = 150
        dateWidthConstraint.constant = 140
        depthWidthConstraint.constant = 150
        layoutIfNeeded()
    }
    
    func setupRegularCompact() {
        timeWidthConstraint.constant = 280
        dateWidthConstraint.constant = 280
        depthWidthConstraint.constant = 280
        layoutIfNeeded()
    }
}
