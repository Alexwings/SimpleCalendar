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
            if start != oldValue{
                self.updateRange()
            }
        }
    }
    var end: Day? {
        didSet {
            if end != oldValue {
                self.updateRange()
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
    
    private func updateRange() {
        guard let start = self.start else {
            clearRange()
            return
        }
        if let end = self.end {
            daylist = findRange(from: start, to: end)
        }else {
            daylist = findRange(from: start, to: start)
        }
    }
    
    //MARK: member methods
    func clearRange() {
        daylist.removeAll()
        self.end = nil
        self.start = nil
    }
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
}
