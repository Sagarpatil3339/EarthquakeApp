//
//  DateTimeExtractor.swift
//  EarthquakeApp
//
//  Created by Prasad Patil on 4/25/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import Foundation

/* For getting time and date from each timestamp in Desired Format*/

// For assigning Days as strings to weekDay from Date Component
enum WeekDay: String, CaseIterable {
    case Mon, Tue, Wed, Thu, Fri, Sat, Sun
    static var weekDayArray: [WeekDay] {return self.allCases}
}

// For assigning Months as strings to month from Date Component
enum Month: String, CaseIterable {
    case Jan, Feb, Mar, Apr, May, June, July, Aug, Sep, Oct, Nov, Dec
    static var monthArray: [Month] {return self.allCases}
}

class DateTimeExtractor {
    
    var time : String = ""
    var date : String = ""
    
    init(Timestamp: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        if let date = dateFormatter.date(from: Timestamp) {
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            let year = calendar.component(.year, from: date)
            let weekDay = WeekDay.weekDayArray[calendar.component(.weekday, from: date)-1]
            let month = Month.monthArray[calendar.component(.month, from: date)-1]
            self.date = "\(weekDay), \(month) \(day), \(year)"
            dateFormatter.dateFormat = Constants.dateFormatForTime
            self.time = dateFormatter.string(from: date)
        }
    }
}
