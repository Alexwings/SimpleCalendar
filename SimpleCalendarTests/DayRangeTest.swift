//
//  DayRangeTest.swift
//  SimpleCalendar
//
//  Created by Xinyuan's on 5/19/17.
//  Copyright © 2017 Xinyuan's. All rights reserved.
//

import XCTest
@testable import SimpleCalendar

class DayRangeTest: XCTestCase {
    
    var sampleDate = Date()
    let fmt = DateFormatter()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        fmt.timeZone = TimeZone.current
        fmt.dateFormat = "yyyy:MM:dd"
        sampleDate = fmt.date(from: "1989:04:26")!
        
    }
    
    func testFindRange() {
        let start = Day(withDate: sampleDate)
        let end = Day(withDate: fmt.date(from: "1989:05:01")!)
        let expected = [Day(withDate: fmt.date(from: "1989:04:26")!),
                        Day(withDate: fmt.date(from: "1989:04:27")!),
                        Day(withDate: fmt.date(from: "1989:04:28")!),
                        Day(withDate: fmt.date(from: "1989:04:29")!),
                        Day(withDate: fmt.date(from: "1989:04:30")!),
                        Day(withDate: fmt.date(from: "1989:05:01")!)]
        let range = DateRange()
        let test: [Day] = range.findRange(from: start, to: end)
        XCTAssertTrue(test.elementsEqual(expected, by: { (d1, d2) -> Bool in
            return d1 == d2
        }))
        let test_1 = range.findRange(from: end, to: start)
        XCTAssertTrue(expected.elementsEqual(test_1, by: {$0 == $1}))
        
    }
    
    func testInitialization() {
        let start = Day(withDate: sampleDate)
        let end = Day(withDate: fmt.date(from: "1989:05:01")!)
        let range = DateRange(startAt: start, endAt: end)
        let expected = [Day(withDate: fmt.date(from: "1989:04:26")!),
                        Day(withDate: fmt.date(from: "1989:04:27")!),
                        Day(withDate: fmt.date(from: "1989:04:28")!),
                        Day(withDate: fmt.date(from: "1989:04:29")!),
                        Day(withDate: fmt.date(from: "1989:04:30")!),
                        Day(withDate: fmt.date(from: "1989:05:01")!)]
        XCTAssertTrue(expected.elementsEqual(range.range, by: {$0 == $1}))
    }
    
    func testStartChange() {
        let start = Day(withDate: sampleDate)
        let end = Day(withDate: fmt.date(from: "1989:05:01")!)
        let range = DateRange(startAt: start, endAt: end)
        let expected_1: [Day] = [Day(withDate: fmt.date(from: "1989:04:28")!),
                        Day(withDate: fmt.date(from: "1989:04:29")!),
                        Day(withDate: fmt.date(from: "1989:04:30")!),
                        Day(withDate: fmt.date(from: "1989:05:01")!)]
        range.start = start.day(byAdding: .day, value: 2)// 2 days after previous start day
        XCTAssertTrue(expected_1.elementsEqual(range.range, by: {$0 == $1}))
        
        let expected_2 = [Day(withDate: fmt.date(from: "1989:04:26")!),
                        Day(withDate: fmt.date(from: "1989:04:27")!),
                        Day(withDate: fmt.date(from: "1989:04:28")!),
                        Day(withDate: fmt.date(from: "1989:04:29")!),
                        Day(withDate: fmt.date(from: "1989:04:30")!),
                        Day(withDate: fmt.date(from: "1989:05:01")!)]
        range.start = start //change back to original start date
        XCTAssertTrue(expected_2.elementsEqual(range.range, by: {$0 == $1}))
        
        let expected_3 = [Day(withDate: fmt.date(from: "1989:04:26")!),
                          Day(withDate: fmt.date(from: "1989:04:27")!),
                          Day(withDate: fmt.date(from: "1989:04:28")!),
                          Day(withDate: fmt.date(from: "1989:04:29")!)]
        
        range.end = end.day(byAdding: .day, value: -2)// 2 days after previous end day
        XCTAssertTrue(expected_3.elementsEqual(range.range, by: {$0 == $1}))
        
        range.end = end// change back to end
        
        XCTAssertTrue(expected_2.elementsEqual(range.range, by: {$0 == $1}))
        
    
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}
