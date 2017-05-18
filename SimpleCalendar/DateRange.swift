//
//  File.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/18/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import Foundation

class DateRange {
    
    //MARK: properties
    var start: Day?
    var end: Day?
    private var daylist: [Day]
    
    //MARK: computed properties
    var range: [Day] {
        get {
            return self.daylist
        }
    }
    
    //MARK: initialize methods
    init() {
        daylist = []
    }
    convenience init(startAt s: Day, endAt e: Day?){
        self.init()
        guard let e = e else {
            self.daylist.append(s)
            return
        }
        self.daylist.sort { return $0 <= $1 }
        self.start = self.daylist.first
        self.end = self.daylist.last
    }
    
    //MARK: member methods
    func findRange(from s: Day, to e: Day ) {
        let startDay = s <= e ? s : e
        let endDay = s >= e ? s : e
        var d: Day? = startDay
        while let cur = d, cur <= endDay {
            daylist.append(cur)
            d = cur.day(byAdding: .day, value: 1, fromDay: cur)
        }
    }
}
