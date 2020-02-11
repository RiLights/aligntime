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
    
    func test_get_wear_timer_for_date_01(){
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        let some_date = "2019/07/12"
        
        let formatter_date = DateFormatter()
        formatter_date.dateFormat = "yyyy/MM/dd HH:mm"
        let provided_time = formatter_date.date(from: "\(some_date) 05:15:00")

        let day0_2 = formatter_date.date(from: "2019/07/11 22:00")
        let day0_1 = formatter_date.date(from: "\(some_date) 01:00")
        let day0 = formatter_date.date(from: "\(some_date) 02:00")
        let day1 = formatter_date.date(from: "\(some_date) 04:00")
        
        let d0_2 = DayInterval()
        d0_2.id = 0
        d0_2.time = day0_2!
        d0_2.wear = false
          
        let d0_1 = DayInterval()
        d0_1.id = 1
        d0_1.time = day0_1!
        d0_1.wear = true

        let d00 = DayInterval()
        d00.id = 2
        d00.time = day0!
        d00.wear = false

        let d01 = DayInterval()
        d01.id = 3
        d01.time = day1!
        d01.wear = true
        
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [d0_2,d0_1,d00,d01]
        
        let test = align_time.get_wear_timer_for_date(update_time:provided_time)
        
        XCTAssertEqual(test, 8100)
    }
    
    func test_get_wear_timer_for_date_02() {
        let df = DateFormatter()
         df.dateFormat = "yyyy/MM/dd"
         let some_date = "2019/07/12"
         
         let formatter_date = DateFormatter()
         formatter_date.dateFormat = "yyyy/MM/dd HH:mm"
         let provided_time = formatter_date.date(from: "\(some_date) 05:00")

         let day0_2 = formatter_date.date(from: "2019/07/11 22:00")
         let day0_1 = formatter_date.date(from: "\(some_date) 01:00")
         let day0 = formatter_date.date(from: "\(some_date) 02:00")
         let day1 = formatter_date.date(from: "\(some_date) 04:00")
         
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
         align_time.intervals = [d0_2,d0_1,d00,d01]
         
         let test = align_time.get_wear_timer_for_date(update_time:provided_time)
         
         XCTAssertEqual(test, 10800)
    }
    
    func test_days_left() {
        let align_time:AlignTime = AlignTime()
        let formatter_date = DateFormatter()
        formatter_date.dateFormat = "yyyy/MM/dd HH:mm"
        let day = formatter_date.date(from: "2019/07/12 00:00")
        
        align_time.required_aligners_total = 74
        align_time.aligner_wear_days = 7
        align_time.start_treatment = day!
        align_time.aligner_number_now = 28
        align_time.current_aligner_days = 1
        
        align_time.update_today_dates()

        let days_result = align_time.days_left
        XCTAssertEqual(days_result, "328")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
