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
    let dateFormatter = DateFormatter()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func get_dayintervals(today_date: String, wears: [Bool]) -> [DayInterval] {
        let day0_2 = dateFormatter.date(from: "2019-07-11 22:00")
        let day0_1 = dateFormatter.date(from: "\(today_date) 01:00")
        let day0 = dateFormatter.date(from: "\(today_date) 02:00")
        let day1 = dateFormatter.date(from: "\(today_date) 04:00")
        
        let d0_2 = DayInterval()
        d0_2.id = 0
        d0_2.time = day0_2!
        d0_2.wear = wears[0]
          
        let d0_1 = DayInterval()
        d0_1.id = 1
        d0_1.time = day0_1!
        d0_1.wear = wears[1]

        let d00 = DayInterval()
        d00.id = 2
        d00.time = day0!
        d00.wear = wears[2]

        let d01 = DayInterval()
        d01.id = 3
        d01.time = day1!
        d01.wear = wears[3]
        
        return [d0_2,d0_1,d00,d01]
    }
    
    func fill_9000_Intervals()->AlignTime{
        let align_time:AlignTime = AlignTime()
        
        var id = 0
        var state = false
        for d in Range(1...20){
            for h in Range(10...20){
                for m in Range(10...50){
                    let time = dateFormatter.date(from: "2019-07-\(d) \(h):\(m)")
                    let d00 = DayInterval()
                    d00.id = id
                    d00.time = time!
                    d00.wear = state
                    id+=1
                    state = !state
                    align_time.intervals.append(d00)
                }
            }
        }
        return align_time
    }
    
    func test_date_string_format() {
        let align_time:AlignTime = AlignTime()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: "2020-02-09")!
        
        let k = align_time.date_string_format(date)
        XCTAssertEqual(k, "2020-02-09")
    }
    
    func test_filter(){
        let today_date = "2019-07-12"
        let provided_time = dateFormatter.date(from: "\(today_date) 05:15")

        let align_time:AlignTime = AlignTime()
        align_time.intervals = get_dayintervals(today_date: today_date, wears: [true,false,true,false])
        XCTAssertEqual(align_time._filter(d: provided_time!, wear: true).count, 1)
        XCTAssertEqual(align_time._filter(d: provided_time!, wear: false).count, 2)
    }
    
    func test_get_wear_timer_for_date_01(){
        let today_date = "2019-07-12"
        let align_time:AlignTime = AlignTime()
        align_time.intervals = get_dayintervals(today_date: today_date, wears: [false,true,false,true])
        let provided_time = dateFormatter.date(from: "\(today_date) 05:15")

        let test = align_time.get_wear_timer_for_date(update_time:provided_time)
        
        XCTAssertEqual(test, 8100)
    }
    
    func test_get_wear_timer_for_date_02() {
         let today_date = "2019-07-12"
         let align_time:AlignTime = AlignTime()
         align_time.intervals = get_dayintervals(today_date: today_date, wears: [true,false,true,false])
         let provided_time = dateFormatter.date(from: "\(today_date) 05:00")

        let test = align_time.get_wear_timer_for_date(update_time: provided_time)
         
         XCTAssertEqual(test, 10800)
    }
    
    func test_get_wear_timer_for_date_03() {
        let today_date = "2019-07-12"

        var base_intervals = get_dayintervals(today_date: today_date, wears: [true,false,true,false])
        let day0 = dateFormatter.date(from: "\(today_date) 20:00")
        
        let d00 = DayInterval()
        d00.id = 4
        d00.time = day0!
        d00.wear = true
        
        base_intervals.append(d00)

        let align_time:AlignTime = AlignTime()
        align_time.intervals = base_intervals
        let provided_time = dateFormatter.date(from: "\(today_date) 23:00")

        let test = align_time.get_wear_timer_for_date(update_time: provided_time)

        XCTAssertEqual(test, 21600)
    }
    
    func test_get_wear_timer_for_date_04() {
        let day0 = dateFormatter.date(from: "2019-07-05 20:00")!
        let d00 = DayInterval(0, wear: true, time: day0)
    
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [d00]
        let provided_time = dateFormatter.date(from: "2019-07-12 01:00")

        let test = align_time.get_wear_timer_for_date(update_time: provided_time)

        XCTAssertEqual(test, 3600)
    }
    
    func test_get_off_timer_for_date_01() {
        let today_date = "2019-07-12"
        let align_time:AlignTime = AlignTime()
        align_time.intervals = get_dayintervals(today_date: today_date, wears: [false,true,false,true])
        let provided_time = dateFormatter.date(from: "\(today_date) 05:00")

        let test = align_time.get_off_timer_for_date(update_time: provided_time)

        XCTAssertEqual(test, 10800)
    }
    
    func test_get_off_timer_for_date_02() {
        let day0 = dateFormatter.date(from: "2019-07-05 20:00")!
        let d00 = DayInterval(0, wear: true, time: day0)
    
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [d00]
        let provided_time = dateFormatter.date(from: "2019-07-12 01:00")

        let test = align_time.get_off_timer_for_date(update_time: provided_time)

        XCTAssertEqual(test, 0)
    }
    
    func test_get_off_timer_for_date_03() {
        let today_date = "2019-07-12"

        var base_intervals = get_dayintervals(today_date: today_date, wears: [true,false,true,false])
        let day0 = dateFormatter.date(from: "\(today_date) 20:00")

        let d00 = DayInterval()
        d00.id = 4
        d00.time = day0!
        d00.wear = true

        base_intervals.append(d00)

        let align_time:AlignTime = AlignTime()
        align_time.intervals = base_intervals
        let provided_time = dateFormatter.date(from: "\(today_date) 23:00")

        let test = align_time.get_off_timer_for_date(update_time: provided_time)

        XCTAssertEqual(test, 61200)
    }
    
    func test_get_off_timer_for_date_04() {
        let day0 = dateFormatter.date(from: "2019-07-05 20:00")!
        let d00 = DayInterval(0, wear: false, time: day0)
    
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [d00]
        let provided_time = dateFormatter.date(from: "2019-07-12 01:00")

        let test = align_time.get_off_timer_for_date(update_time: provided_time)

        XCTAssertEqual(test, 3600)
    }
    
    func test_get_wear_days_01(){
        let selected_date = "2019-07-12"
        let day0 = dateFormatter.date(from: "2019-07-11 10:00")!
        let day1 = dateFormatter.date(from: "2019-07-11 20:00")!
        let day2 = dateFormatter.date(from: "2019-07-13 10:00")!
        let day3 = dateFormatter.date(from: "2019-07-13 20:00")!
        
        let d00 = DayInterval(0, wear: true, time: day0)
        let d01 = DayInterval(1, wear: false, time: day1)
        let d02 = DayInterval(2, wear: true, time: day2)
        let d03 = DayInterval(3, wear: false, time: day3)
    
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [d00,d01,d02,d03]
        let provided_time = dateFormatter.date(from: "\(selected_date) 01:00")
        align_time.selected_date = provided_time
        
        let test = align_time.get_wear_days()

        XCTAssertEqual(test, [])
    }
    
    func test_get_wear_days_02(){
        let day0 = dateFormatter.date(from: "2019-07-11 10:00")!
        let day1 = dateFormatter.date(from: "2019-07-11 20:00")!
        let day2 = dateFormatter.date(from: "2019-07-12 10:00")!
        let day3 = dateFormatter.date(from: "2019-07-12 20:00")!
        
        let d00 = DayInterval(0, wear: false, time: day0)
        let d01 = DayInterval(1, wear: true, time: day1)
        let d02 = DayInterval(2, wear: false, time: day2)
        let d03 = DayInterval(3, wear: true, time: day3)
    
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [d00,d01,d02,d03]
        align_time.selected_date = day3
        
        let test = align_time.get_wear_days()

        let correct_data = [d01,d03]
        XCTAssertEqual(test, correct_data)
    }
    
    func test_get_wear_days_03(){
        let day0 = dateFormatter.date(from: "2019-07-10 10:00")!
        let day1 = dateFormatter.date(from: "2019-07-10 20:00")!
        let day2 = dateFormatter.date(from: "2019-07-12 10:00")!
        let day3 = dateFormatter.date(from: "2019-07-12 20:00")!
        
        let d00 = DayInterval(0, wear: true, time: day0)
        let d01 = DayInterval(1, wear: false, time: day1)
        let d02 = DayInterval(2, wear: true, time: day2)
        let d03 = DayInterval(3, wear: false, time: day3)
    
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [d00,d01,d02,d03]
        align_time.selected_date = day3
        
        let test = align_time.get_wear_days()

        let correct_data = [d02]
        XCTAssertEqual(test, correct_data)
    }
    
    func test_get_off_days_01(){
        let day0 = dateFormatter.date(from: "2019-07-11 10:00")!
        let day1 = dateFormatter.date(from: "2019-07-11 20:00")!
        let day2 = dateFormatter.date(from: "2019-07-13 10:00")!
        let day3 = dateFormatter.date(from: "2019-07-13 20:00")!
        
        let d00 = DayInterval(0, wear: true, time: day0)
        let d01 = DayInterval(1, wear: false, time: day1)
        let d02 = DayInterval(2, wear: true, time: day2)
        let d03 = DayInterval(3, wear: false, time: day3)
    
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [d00,d01,d02,d03]
        align_time.selected_date = dateFormatter.date(from: "2019-07-12 01:00")
        
        let test = align_time.get_off_days()

        XCTAssertEqual(test, [])
    }
    
    func test_get_off_days_02(){
        let day0 = dateFormatter.date(from: "2019/12/08 08:40")
        let day1 = dateFormatter.date(from: "2019/12/08 15:00")
        let day2 = dateFormatter.date(from: "2019/12/08 20:00")
        let day3 = dateFormatter.date(from: "2019/12/09 01:00")
        let day4 = dateFormatter.date(from: "2019/12/09 02:00")
        let day5 = dateFormatter.date(from: "2020/02/02 05:00")
        
        let d00 = DayInterval(0, wear: false, time: day0!)
        let d01 = DayInterval(1, wear: true, time: day1!)
        let d02 = DayInterval(2, wear: false, time: day2!)
        let d03 = DayInterval(3, wear: true, time: day3!)
        let d04 = DayInterval(4, wear: false, time: day4!)
        let d05 = DayInterval(5, wear: true, time: day5!)
    
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [d00,d01,d02,d03,d04,d05]
        align_time.selected_date = day3
        
        let test = align_time.get_off_days()
        
        let correct_data:[DayInterval] = [d02,d04]
        XCTAssertEqual(test, correct_data)
    }
    
    func test_get_off_days_03(){
        let day1 = dateFormatter.date(from: "2019-12-06 15:00")!
        let day2 = dateFormatter.date(from: "2019-12-07 21:20")!
        let day3 = dateFormatter.date(from: "2019-12-07 22:15")!

        let d01 = DayInterval(1, wear: false, time: day1)
        let d02 = DayInterval(2, wear: true, time: day2)
        let d03 = DayInterval(3, wear: false, time: day3)
    
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [d01,d02,d03]
        align_time.selected_date = day3
        
        let test = align_time.get_off_days()
        
        let correct_data:[DayInterval] = [d01,d03]
        XCTAssertEqual(test, correct_data)
    }
    
    func test_get_off_days_04(){
        let day0 = dateFormatter.date(from: "2019-07-11 10:00")!
        let day1 = dateFormatter.date(from: "2019-07-11 20:00")!
        let day2 = dateFormatter.date(from: "2019-07-12 10:00")!
        let day3 = dateFormatter.date(from: "2019-07-13 20:00")!
        
        let d00 = DayInterval(0, wear: true, time: day0)
        let d01 = DayInterval(1, wear: false, time: day1)
        let d02 = DayInterval(2, wear: true, time: day2)
        let d03 = DayInterval(3, wear: false, time: day3)
    
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [d00,d01,d02,d03]
        align_time.selected_date = day2
        
        let test = align_time.get_off_days()

        let correct_data:[DayInterval] = [d01]
        XCTAssertEqual(test, correct_data)
    }
    
    func test_get_off_days_05(){
        let day0 = dateFormatter.date(from: "2019-07-11 10:00")!
        let day1 = dateFormatter.date(from: "2019-07-11 20:00")!
        let day2 = dateFormatter.date(from: "2019-07-12 10:00")!
        let day3 = dateFormatter.date(from: "2019-07-13 20:00")!
        
        let d00 = DayInterval(0, wear: false, time: day0)
        let d01 = DayInterval(1, wear: true, time: day1)
        let d02 = DayInterval(2, wear: false, time: day2)
        let d03 = DayInterval(3, wear: true, time: day3)
    
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [d00,d01,d02,d03]
        align_time.selected_date = day2
        
        let test = align_time.get_off_days()

        let correct_data = [d02]
        XCTAssertEqual(test, correct_data)
    }
    
    
    func test_days_left() {
        let align_time:AlignTime = AlignTime()
        let day = dateFormatter.date(from: "2019-07-12 00:00")
        
        align_time.required_aligners_total = 74
        align_time.aligner_wear_days = 7
        align_time.start_treatment = day!
        align_time.aligner_number_now = 28
        align_time.current_aligner_days = 1
        
        align_time.update_today_dates()

        let days_result = align_time.days_left
        XCTAssertEqual(days_result, "328")
    }

    func testFilterPerformance() {
        let align_time:AlignTime = fill_9000_Intervals()
        let provided_time = dateFormatter.date(from: "2019-07-12 05:15")!
        measure {
            _ = align_time.get_wear_timer_for_date(update_time: provided_time)
        }
    }
}
