//
//  File.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/18/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import Foundation

class DateRange: NSObject{
    
    //MARK: properties
    var start: Day? {
        didSet {
            if let start = start, let end = end, let first = oldValue, start != first {
                if start < first {
                    self.daylist = findRange(from: start, to: end)
                }else if start > end {
                    self.daylist = findRange(from: first, to: start)
                }else {
                    self.daylist = findRange(from: start, to: end)
                }
            }
        }
    }
    var end: Day? {
        didSet {
            if let start = start, let end = end, let last = oldValue, end != last {
                if last > end {
                    self.daylist = findRange(from: start, to: end)
                }else if end < start{
                    self.daylist = findRange(from: end, to: start)
                }else {
                    self.daylist = findRange(from: start, to: end)
                }
            }
        }
    }
    private var daylist: [Day]
    
    //MARK: computed properties
    var range: [Day] {
        get {
            return self.daylist
        }
    }
    
    //MARK: initialize methods
    override init() {
        daylist = []
    }
    convenience init(startAt s: Day, endAt e: Day?){
        self.init()
        guard let e = e else {
            self.daylist.append(s)
            return
        }
        self.daylist = findRange(from: s, to: e)
        self.start = self.daylist.first
        self.end = self.daylist.last
    }
    
    //MARK: member methods
    func findRange(from s: Day, to e: Day ) -> [Day] {
        let startDay = s <= e ? s : e
        let endDay = s >= e ? s : e
        var res: [Day] = []
        var d: Day? = startDay
        while let cur = d, cur <= endDay {
            res.append(cur)
            d = cur.day(byAdding: .day, value: 1)
        }
        return res.sorted { return $0 < $1 }
    }
    
    func remove(day: Day) -> Bool {
        guard daylist.contains(day), let index = daylist.index(of: day) else { return false }
        guard day > daylist[daylist.startIndex] else {
            start = daylist[daylist.index(after: daylist.startIndex)]
            return true
        }
        let prevDayIndex = daylist.index(before: index)
        end = daylist[prevDayIndex]
        return true
    }
}
