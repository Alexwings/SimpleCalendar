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
    let week: Int // week of the year
    let weekday: Weekdays
    
    //MARK: class utilities 
    //TODO: Date formatter and class method to convert date to formatted string
//    static let fomatter: DateFormatter = {
//    }()
    
    /*Description: class methods to help extract date components needed in Day class from given Date object
     *parameters:
     *  fromDate: the Date object want to be converted
     *return:
     *  (year, month, day, week, weekday) -> a tuple that contains all the needed information of a Day object extracted from give date
     */
    class func dateComponents(fromDate date: Date) -> (year: Int, month: Int, day: Int, week: Int, weekday: Weekdays) {
        let components = Calendar.current.dateComponents([.year, .month, .day, .weekOfYear, .weekday], from: date)
        let weekday = Weekdays.weekday(fromNumber: components.weekday ?? 0)
        return (components.year ?? 0, components.month ?? 0, components.day ?? 0, components.weekOfYear ?? 0, weekday)
    }
    
    //MAKR: initialize methods
    init(withDate date: Date){
        let components = Day.dateComponents(fromDate: date)
        self.date = date
        self.year = components.year
        self.month = components.month
        self.day = components.day
        self.week = components.week
        self.weekday = components.weekday
    }
    
    func day(byAdding component: Calendar.Component, value: Int, fromDay: Day) -> Day? {
        guard let tommorrow = Calendar.current.date(byAdding: component, value: value, to: self.date) else { return nil }
        return Day(withDate: tommorrow)
    }
    
}

extension Day: Comparable{
    /*Description: left hand side day is the same day with the right hand side day
     *parameters:
     *return: true if left and right are same day
     */
    static func ==(lhs: Day, rhs: Day) -> Bool {
        return (lhs.year == rhs.year) && (lhs.month == rhs.month) && (lhs.day == rhs.day)
    }
    
    /*Description: left hand side day is earlier then the right hand side day
     *parameters:
     *return: true if left is earlier then right
     */
    static func <(lhs: Day, rhs: Day) -> Bool {
        guard lhs.year == rhs.year else { return lhs.year < rhs.year }
        guard lhs.month == rhs.month else { return lhs.month < rhs.month }
        return lhs.day < rhs.day
    }
    
    /*Description: left hand side day is earlier then the right hand side day or they are the same day
     *parameters:
     *return: true if left is earlier then right or they are the same day
     */
    static func <=(lhs: Day, rhs: Day) -> Bool {
        return lhs == rhs || lhs < rhs
    }
    
    /*Description: left hand side day is later then the right hand side day
     *parameters:
     *return: true if left is later then right
     */
    static func >(lhs: Day, rhs: Day) -> Bool {
        guard lhs.year == rhs.year else { return lhs.year > rhs.year }
        guard lhs.month == rhs.month else { return lhs.month > rhs.month }
        return lhs.day > rhs.day
    }
    /*Description: left hand side day is earlier then the right hand side day or they are the same day
     *parameters:
     *return: true if left is earlier then right or they are the same day
     */
    static func >=(lhs: Day, rhs: Day) -> Bool {
        return lhs == rhs || lhs > rhs
    }
}
