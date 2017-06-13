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
    
    var currentMonth: [Day] = []
    
    private var selectedRange: DateRange = DateRange()
    
    var startDay: Day? {
        get {
            return selectedRange.start
        }
    }
    
    var endDay: Day? {
        get {
            return selectedRange.end
        }
    }
    
    weak var controller: UIViewController?
    
    init(withController controller: UIViewController) {
        super.init()
        self.controller = controller
    }
    //select the date range according to previous selected range
    func select(day: Day?, completionHandler: @escaping ([Int]) -> Void) {
        guard let day = day else {
            DispatchQueue.main.async {
                completionHandler([])
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
            return self.currentMonth.index(where: { $0 == day}) ?? -1
        }
        DispatchQueue.main.async {
            completionHandler(indices)
        }
    }
    //deselect the date range according to previous selected range, will always deselect the given day to the end of the selected range except the given day is the start day"
    func deselect(day: Day?, completionHandler: @escaping ([Int]) -> Void) {
        guard let day = day else {
            DispatchQueue.main.async {
                completionHandler([])
            }
            return
        }
    }
}


