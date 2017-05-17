//
//  Day.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/16/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import Foundation

class Day {
    //instance property
    let date: Date
    let year: Int
    let month: Int
    let day: Int
    let week: Int
    let weekday: Weekdays
    
    init(withDate date: Date){
        let components = Day.dateComponents(fromDate: date)
        self.date = date
        self.year = components.year
        self.month = components.month
        self.day = components.day
        self.week = components.week
        self.weekday = components.weekday
    }
}

extension Day {
    class func dateComponents(fromDate date: Date) -> (year: Int, month: Int, day: Int, week: Int, weekday: Weekdays) {
        let components = Calendar.current.dateComponents([.year, .month, .day, .weekOfYear, .weekday], from: date)
        let weekday = Weekdays.weekday(fromNumber: components.weekday ?? 0)
        return (components.year ?? 0, components.month ?? 0, components.day ?? 0, components.weekOfYear ?? 0, weekday)
    }
}
