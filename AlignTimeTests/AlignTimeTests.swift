//
//  AlignTimeTests.swift
//  AlignTimeTests
//
//  Created by Ostap on 3/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import XCTest
@testable import AlignTime

class AlignTimeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_date_string_format() {
        let align_time:AlignTime = AlignTime()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: "2020-02-09")!
        
        let k = align_time.date_string_format(date)
        XCTAssertEqual(k, "2020-02-09")
    }
    
    func test_intervals() {
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        let now = df.string(from: Date())
        
        let formatter_date = DateFormatter()
        formatter_date.dateFormat = "yyyy/MM/dd HH:mm"
        let day0_2 = formatter_date.date(from: "\(now) 00:15")
        let day0_1 = formatter_date.date(from: "\(now) 02:20")
        let day0 = formatter_date.date(from: "\(now) 15:15")
        let day1 = formatter_date.date(from: "\(now) 23:15")
        
        let d0_2 = DayInterval()
        d0_2.id = 0
        d0_2.time = day0_2!
        d0_2.wear = true
          
        let d0_1 = DayInterval()
        d0_1.id = 1
        d0_1.time = day0_1!
        d0_1.wear = false

        let d00 = DayInterval()
        d00.id = 2
        d00.time = day0!
        d00.wear = true

        let d01 = DayInterval()
        d01.id = 3
        d01.time = day1!
        d01.wear = false
        
        let align_time:AlignTime = AlignTime()
        align_time.intervals.append(contentsOf: [d0_2,d0_1,d00,d01])
        
        let test = align_time.get_wear_timer_for_today()
        
        XCTAssertEqual(test, "00:00:00") //  ("-3 041:55:00") ????
          
    }
/*
    func test_days_left() {
        let align_time:AlignTime = AlignTime()
        do {
            try align_time.update_today_dates()
        } catch {}

        let days_result = align_time.days_left
        XCTAssertEqual(days_result, "219")
    }
*/
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
