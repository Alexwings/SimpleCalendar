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
        set {
            selectedRange.start = newValue
        }
    }
    
    var endDay: Day? {
        get {
            return selectedRange.end
        }
        set {
            selectedRange.end = newValue
        }
    }
    
    weak var controller: UIViewController?
    
    init(withController controller: UIViewController) {
        super.init()
        self.controller = controller
    }
    
    private func findSelected() -> [Int] {
        if let start = selectedRange.start, let end = selectedRange.end {
            let startIndex: Int = currentMonth.index(of: start)!
            let endIndex: Int = currentMonth.index(of: end)!
            return Array<Int>(startIndex...endIndex)
        }
        return []
    }
    private func findDeselected(toDay day: Day) -> [Int] {
        guard let start = startDay, let end = endDay else { return [] }
        guard start <= day && end >= day else { return [] }
        guard let index = currentMonth.index(of: day) else { return [] }
        return [Int](0...index)
    }
}


