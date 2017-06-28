//
//  CalendarModel.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/16/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import Foundation
import UIKit

class CalendarViewModel: NSObject {
    
    //MARK:public property
    var currentMonth: [Day] = [] {
        didSet {
            if !currentMonth.isEmpty, let first = currentMonth.first {
                startWeekDay = first.weekday
            }
        }
    }
    var startWeekDay: Weekdays = Weekdays.undefined {
        didSet {
            if startWeekDay != .undefined {
                let num: Double = Double(currentMonth.count + startWeekDay.number()) / 7.0
                numberOfRows = ceil(num)
            }
        }
    }// starting position
    
    var monthString: String {
        get {
            guard let firstDay = currentMonth.first else { return ""} 
            let month = firstDay.monthString
            return month + ", " + firstDay.yearString
        }
    }
    var startDay: Day? {
        set {
            if let s = newValue {
                selectedRange.start = s
            }
        }
        get {
            return selectedRange.start
        }
    }
    
    var endDay: Day? {
        set {
            if let e = newValue {
                selectedRange.end = e
            }
        }
        get {
            return selectedRange.end
        }
    }
    
    var range: [Day] {
        get {
            return self.selectedRange.range
        }
    }
    var numberOfRows: Double = 0.0;
    
    weak var controller: UIViewController?
    
    //MARK:private property
    private var selectedRange: DateRange = DateRange()
    

    //MARK: Override methods
    init(withController controller: UIViewController) {
        super.init()
        self.controller = controller
        let currentDate = Date()
        let currentDay = Day(withDate: currentDate)
        self.update(withDate: currentDay)
    }
    
    //MARK: Public methods
    //select the date range according to previous selected range
    func select(day: Day?, completionHandler: @escaping ([Int]?) -> Void) {
        guard let day = day else {
            DispatchQueue.main.async {
                completionHandler(nil)
            }
            return
        }
        
        if selectedRange.range.isEmpty {
            selectedRange.start = day
        }else if let start = selectedRange.start {
            if day >= start {
                selectedRange.end = day
            }else {
                selectedRange.start = day
                selectedRange.end = start
            }
        }else if let end = selectedRange.end {
            if day >= end {
                selectedRange.start = day
            }else {
                selectedRange.start = end
                selectedRange.end = day
            }
        }
        //find the index of the selected days in current month.
        let selected = self.selectedRange.range
        let indices = selected.map {[unowned self] (day) -> Int in
            let index = self.currentMonth.index(where: { $0 == day}) ?? -1
            return (index != -1 ? index + self.startWeekDay.number() - 1 : index)
        }
        DispatchQueue.main.async {
            completionHandler(indices)
        }
    }
    //deselect the date range according to previous selected range, will always deselect the given day to the end of the selected range except the given day is the start day"
    func deselect(day: Day?, completionHandler: @escaping ([Int]?) -> Void) {
        guard let day = day, let start = startDay, day >= start else {
            DispatchQueue.main.async {
                completionHandler(nil)
            }
            return
        }
        //cache the original selected range
        //get the index of the unselected day in original range
        let selected = selectedRange.range
        let curIndex = selected.index(where: { $0 == day }) ?? selected.endIndex
        //if the unselected day is start date of the original range, clear the original range
        //else set the end of selected range to the day before the unselected day
        if let start = startDay, day == start {
            selectedRange.start = nil
            selectedRange.end = nil
        }else {
            let selectedEndIndex = selected.index(before: curIndex)
            selectedRange.end = selected[selectedEndIndex]
        }
        //find the unselected days after alter the end of the selected range
        var unselected: [Day] = []
        for (i, d) in selected.enumerated() {
            if i > curIndex {
                unselected.append(d)
            }
        }
        //transform the unselected days array to array of the index of those unselected days.
        let indices: [Int] = unselected.map { [unowned self](d) -> Int in
            let index = self.currentMonth.index(where: { $0 == d}) ?? -1
            let newIndex = (index == -1) ? index : (index + self.startWeekDay.number() - 1)
            return newIndex
        }
        DispatchQueue.main.async {
            completionHandler(indices)
        }
    }
    
    func update(withDate day: Day) {
        let date = day.date
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        guard let rawMonthRange = calendar.range(of: .day, in: .month, for: date) else { return }
        let monthRange = rawMonthRange.lowerBound..<rawMonthRange.upperBound
        currentMonth = monthRange.map({ (dayNumber) -> Day in
            var components = DateComponents()
            components.year = year
            components.month = month
            components.day = dayNumber
            let currentDate = calendar.date(from: components)
            return Day(withDate: currentDate ?? Date(timeIntervalSince1970: -1))
        }).filter({ (day) -> Bool in
            return day != Day(withDate: Date(timeIntervalSince1970: -1))
        })
    }

}


