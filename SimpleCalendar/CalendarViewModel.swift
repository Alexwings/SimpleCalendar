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
    
    func select(day: Day?, completionHandler: @escaping ([Int]) -> Void) {
        guard let day = day else { return }
        if selectedRange.range.isEmpty, let s = startDay {
            if day < s { endDay = s; startDay = day}
            else { endDay = day }
        }else if selectedRange.range.isEmpty, let e = endDay {
            if day <= e { startDay = day }
            else { startDay = e; endDay = day }
        }else if let s = startDay, let _ = endDay {
            if day < s { startDay = day }
            else { endDay = day }
        }
        let indices = findSelected()
        if !indices.isEmpty{
            completionHandler(indices)
        }
    }
    //find the selected indices in current month
    private func findSelected() -> [Int] {
        if let start = startDay, let end = endDay {
            let startIndex: Int? = currentMonth.index(of: start)
            let endIndex: Int? = currentMonth.index(of: end)
            if let sindex = startIndex, let eindex = endIndex {
                return Array<Int>(sindex...eindex)
            }else if let sindex = startIndex{
                return Array<Int>(sindex..<currentMonth.endIndex)
            }else if let eindex = endIndex {
                return Array<Int>(currentMonth.startIndex...eindex)
            }
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


