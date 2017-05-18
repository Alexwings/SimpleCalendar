//
//  ModelTest.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/18/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import XCTest
import Foundation
import SimpleCalendar

class ModelTest: XCTestCase {
    
    let cal: Calendar = Calendar.current
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDayCreate() {
        //setup
        let today = Date()
        let yearOnly = cal.dateComponents([.year], from: today)
        let yearAndMonth = cal.dateComponents([.year, .month], from: today)
        let yearMontAndDay = cal.dateComponents([.year, .month, .day], from: today)
        let MonthAndDay = cal.dateComponents([.month, .day], from: today)
        let MonthOnly = cal.dateComponents([.month], from: today)
        let DayOnly = cal.dateComponents([.day], from: today)
        let weekday = cal.dateComponents([.weekday], from: today)
        let weekOfYear = cal.dateComponents([.weekOfYear], from: today)
        
        let day_1 = Day(cal.date(from: yearOnly))
        
        //teardown
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
