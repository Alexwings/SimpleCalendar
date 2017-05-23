//
//  ModelTest.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/18/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import XCTest
import Foundation
@testable import SimpleCalendar

class ModelTest: XCTestCase {
    
    let cal: Calendar = Calendar.current
    let formatter: DateFormatter = DateFormatter()
    
    override func setUp() {
        super.setUp()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy:MM:dd"
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
        
        if let date = cal.date(from: yearOnly) {
            let day = Day(withDate: date)
            XCTAssertEqual(day.year, cal.component(.year, from: today))
        }
        
        if let date = cal.date(from: yearAndMonth) {
            let day = Day(withDate: date)
            XCTAssertEqual(day.year, cal.component(.year, from: today))
            XCTAssertEqual(day.month, cal.component(.month, from: today))
        }
        
        if let date = cal.date(from: yearMontAndDay) {
            let day = Day(withDate: date)
            XCTAssertEqual(day.year, cal.component(.year, from: today))
            XCTAssertEqual(day.day, cal.component(.day, from: today))
            XCTAssertEqual(day.month, cal.component(.month, from: today))
            XCTAssertEqual(day.week, cal.component(.weekOfYear, from: today))
        }
        if let date = cal.date(from: MonthAndDay) {
            let day = Day(withDate: date)
            XCTAssertEqual(day.day, cal.component(.day, from: today))
            XCTAssertEqual(day.month, cal.component(.month, from: today))
        }
        
        if let date = cal.date(from: MonthOnly) {
            let day = Day(withDate: date)
            XCTAssertEqual(day.month, cal.component(.month, from: today))
        }
        
        if let date = cal.date(from: DayOnly) {
            let day = Day(withDate: date)
            XCTAssertEqual(day.day, cal.component(.day, from: today))
        }
        //teardown
    }
    
    func testDayProceed() {
        //setup
        let today = formatter.date(from: "1989:04:26")!
        let todayDay = Day(withDate: today)
        //testcase
        var day = todayDay.day(byAdding: .day, value: 1)
        if let day = day {
            XCTAssertEqual(day.day, 27)
        }else {
            XCTAssertNil(day)
        }
        day = todayDay.day(byAdding: .day, value: -1)
        if let day = day {
            XCTAssertEqual(day.day, 25)
        }else {
            XCTAssertNil(day)
        }
        //teardown
    }
    
    func testComparable() {
        let lhs = Day(withDate: formatter.date(from: "2017:01:01")!)
        let rhs_1 = Day(withDate: formatter.date(from: "2016:01:01")!)
        let rhs_2 = Day(withDate: formatter.date(from: "2017:02:01")!)
        let rhs_3 = Day(withDate: formatter.date(from: "2017:01:03")!)
        
        XCTAssertTrue(lhs == lhs)
        XCTAssertFalse(lhs == rhs_1)
        XCTAssertFalse(lhs != lhs)
        XCTAssertTrue(lhs > rhs_1)
        XCTAssertTrue(lhs < rhs_2)
        XCTAssertTrue(lhs < rhs_3)
        XCTAssertTrue(lhs <= rhs_2)
        XCTAssertTrue(rhs_2 >= lhs)
        XCTAssertTrue(lhs <= lhs)
        XCTAssertTrue(lhs >= lhs)
    }
    
    func findSelected() {
        let vm = CalendarViewModel(withController: UIViewController())
        let vm =
        let start_1 = Day(withDate: formatter.date(from: "1989:04:26")!)
        let start_2 = Day(withDate: formatter.date(from: "1989:03:26")!)
        let end_1 = Day(withDate: formatter.date(from: "1989:04:30")!)
        let end_2 = Day(withDate: formatter.date(from: "1989:05:26")!)
        
    }
    
}
