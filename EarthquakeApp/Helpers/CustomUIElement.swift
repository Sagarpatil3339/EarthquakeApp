//
//  CustomUIElement.swift
//  EarthquakeApp
//
//  Created by Prasad Patil on 4/25/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import UIKit

/* For customising different UI Elements and assigning values to their properties*/

class CustomUIElement {

    // Screen window size in terms of variables for height and width
    static var windowWidth: CGFloat = UIScreen.main.bounds.width
    static var windowHeight: CGFloat = UIScreen.main.bounds.height
    
    // For customising UILabel's attributes
    static func forLabel(sender: UILabel,name: String, size: CGFloat, textColor: UIColor? = UIColor.darkText, textAlignment: NSTextAlignment?){
        sender.font = UIFont(name: name, size: size)
        sender.numberOfLines = 0
        sender.textColor = textColor
        if let textAlignment = textAlignment {
        sender.textAlignment = textAlignment
        }
    }
}
