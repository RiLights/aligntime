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
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600*2)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_DayInterval() {
        let json = """
        {
            "id": 0,
            "timestamp": 1581774489061,
            "wear": true,
            "time_string": "12:00"
        }
        """.data(using: .utf8)!
                
        let day0 = try! JSONDecoder().decode(DayInterval.self, from: json)
        
        XCTAssertEqual(day0.id, 0)
    }
    
    func test_DayIntervals() {
        let day0 = dateFormatter.date(from: "2018-07-11 10:00")!
        let day1 = dateFormatter.date(from: "2019-07-12 20:00")!
        let day2 = dateFormatter.date(from: "2019-07-13 10:00")!
        let day3 = dateFormatter.date(from: "2019-07-13 20:00")!
        
        let d00 = DayInterval(0, wear: true, time: day0)
        let d01 = DayInterval(1, wear: false, time: day1)
        let d02 = DayInterval(2, wear: true, time: day2)
        let d03 = DayInterval(3, wear: false, time: day3)
      
        let d00_encoded = try! JSONEncoder().encode(d00)
        let d01_encoded = try! JSONEncoder().encode(d01)
        let d02_encoded = try! JSONEncoder().encode(d02)
        let d03_encoded = try! JSONEncoder().encode(d03)
        
        let test_d00 = try! JSONDecoder().decode(DayInterval.self, from: d00_encoded)
        let test_d01 = try! JSONDecoder().decode(DayInterval.self, from: d01_encoded)
        let test_d02 = try! JSONDecoder().decode(DayInterval.self, from: d02_encoded)
        let test_d03 = try! JSONDecoder().decode(DayInterval.self, from: d03_encoded)
        
        let intervals = [d00,d01,d02,d03]
        let encoded = try? JSONEncoder().encode(intervals)
        let decoded = try? JSONDecoder().decode([DayInterval].self, from: encoded!)
                      
        XCTAssertEqual(intervals, decoded)
        XCTAssertEqual(test_d00.timestamp, d00.timestamp)
        XCTAssertEqual([d00,d01,d02,d03], [test_d00,test_d01,test_d02,test_d03])
    }
    
    func get_dayintervals2() -> [DayInterval] {
        /*
         timestamp 2019-12-06 14:00:00 +0000
         wear false
         timestamp 2019-12-07 20:20:00 +0000
         wear true
         timestamp 2019-12-07 21:15:00 +0000
         wear false
         timestamp 2019-12-07 23:15:00 +0000
         wear true
         timestamp 2019-12-07 23:20:00 +0000
         wear false
         timestamp 2019-12-08 00:40:00 +0000
         wear true
         timestamp 2019-12-08 07:40:00 +0000
         wear false
         timestamp 2019-12-08 14:00:00 +0000
         wear true
         timestamp 2019-12-08 19:00:00 +0000
         wear false
         timestamp 2019-12-09 00:00:00 +0000
         wear true
         timestamp 2019-12-09 01:00:00 +0000
         wear false
         timestamp 2020-02-02 04:00:00 +0000
         wear true
         timestamp 2020-02-02 06:15:00 +0000
         wear false
         timestamp 2020-02-02 08:12:00 +0000
         wear true
         timestamp 2020-02-15 14:38:45 +0000
         wear false
         timestamp 2020-02-15 14:38:57 +0000
         wear true
         timestamp 2020-02-15 14:38:59 +0000
         wear false
         */
        let json_objects = [ "{\"id\":0,\"timestamp\":1575640800000,\"wear\":false,\"time_string\":\"15:00\"}"
        ,"{\"id\":1,\"timestamp\":1575750000000,\"wear\":true,\"time_string\":\"21:20\"} "
        ,"{\"id\":2,\"timestamp\":1575753300000,\"wear\":false,\"time_string\":\"22:15\"} "
        ,"{\"id\":3,\"timestamp\":1575760500000,\"wear\":true,\"time_string\":\"00:15\"} "
        ,"{\"id\":4,\"timestamp\":1575760800000,\"wear\":false,\"time_string\":\"00:20\"} "
        ,"{\"id\":5,\"timestamp\":1575765600000,\"wear\":true,\"time_string\":\"01:40\"} "
        ,"{\"id\":6,\"timestamp\":1575790800000,\"wear\":false,\"time_string\":\"08:40\"} "
        ,"{\"id\":7,\"timestamp\":1575813600000,\"wear\":true,\"time_string\":\"15:00\"} "
        ,"{\"id\":8,\"timestamp\":1575831600000,\"wear\":false,\"time_string\":\"20:00\"} "
        ,"{\"id\":9,\"timestamp\":1575849600000,\"wear\":true,\"time_string\":\"01:00\"} "
        ,"{\"id\":10,\"timestamp\":1575853200000,\"wear\":false,\"time_string\":\"02:00\"} "
        ,"{\"id\":11,\"timestamp\":1580616000000,\"wear\":true,\"time_string\":\"05:00\"} "
        ,"{\"id\":12,\"timestamp\":1580624100000,\"wear\":false,\"time_string\":\"07:15\"} "
        ,"{\"id\":13,\"timestamp\":1580631120000,\"wear\":true,\"time_string\":\"09:12\"} "
        ,"{\"id\":14,\"timestamp\":1581777525215,\"wear\":false,\"time_string\":\"15:38\"} "
        ,"{\"id\":15,\"timestamp\":1581777537065,\"wear\":true,\"time_string\":\"15:38\"} "
        ,"{\"id\":16,\"timestamp\":1581777539921,\"wear\":false,\"time_string\":\"15:38\"} " ]
        
        var intervals:[DayInterval] = []
        for str in json_objects {
            let json = str.data(using: .utf8)!
            let d00 = try! JSONDecoder().decode(DayInterval.self, from: json)
            intervals.append(d00)
        }
        
        return intervals
    }
    
    func testDayIntervalsFilter() {
        let intervals = get_dayintervals2()
        let align_time:AlignTime = AlignTime()
        align_time.intervals = intervals
        align_time.selected_date = dateFormatter.date(from: "2019-12-07 21:15")
        let test = align_time.get_wear_days()
        XCTAssertEqual(test, [ intervals[1] ])
    }
    
    func test_is_present() {
        let intervals = get_dayintervals2()
        let align_time:AlignTime = AlignTime()
        align_time.intervals = intervals
        let selected_date = dateFormatter.date(from: "2019-12-07 23:15")!
        XCTAssertEqual(true, align_time.is_present(selected_date) )
    }
    
    func test_is_between() {
        let intervals = get_dayintervals2()
        let align_time:AlignTime = AlignTime()
        align_time.intervals = intervals
        let selected_date = dateFormatter.date(from: "2019-12-08 23:15")!
        XCTAssertEqual(true, align_time.is_between(selected_date) )
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
        
        let test = align_time.get_wear_days()

        XCTAssertEqual(test, [])
    }
    
    func test_get_wear_days_02(){
        let day0 = dateFormatter.date(from: "2019-07-11 10:00")!
        let day1 = dateFormatter.date(from: "2019-07-11 20:00")!
        let day2 = dateFormatter.date(from: "2019-07-12 10:00")!
        let day3 = dateFormatter.date(from: "2019-07-12 20:00")!
        
        let off00 = DayInterval(0, wear: false, time: day0)
        let wear01 = DayInterval(1, wear: true, time: day1)
        let off02 = DayInterval(2, wear: false, time: day2)
        let wear03 = DayInterval(3, wear: true, time: day3)
    
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [off00,wear01,off02,wear03]
        align_time.selected_date = day3
        
        let test = align_time.get_wear_days()

        let correct_data = [wear01,wear03]
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
        align_time.selected_date = dateFormatter.date(from: "2019/12/09 01:00")
        
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
        align_time.aligners_wear_days = 7
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
