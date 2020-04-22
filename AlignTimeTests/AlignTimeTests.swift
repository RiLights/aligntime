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
        //dateFormatter.timeZone = TimeZone(identifier: "Europe/Warsaw")!
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
            "time_string": "12:00",
            "timezone":{"identifier":"Europe/Warsaw"}
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
         timestamp 2019-12-06 14:00:00 +0000 wear false
         timestamp 2019-12-07 20:20:00 +0000 wear true
         timestamp 2019-12-07 21:15:00 +0000 wear false
         timestamp 2019-12-07 23:15:00 +0000 wear true
         timestamp 2019-12-07 23:20:00 +0000 wear false
         timestamp 2019-12-08 00:40:00 +0000 wear true
         timestamp 2019-12-08 07:40:00 +0000 wear false
         timestamp 2019-12-08 14:00:00 +0000 wear true
         timestamp 2019-12-08 19:00:00 +0000 wear false
         timestamp 2019-12-09 00:00:00 +0000 wear true
         timestamp 2019-12-09 01:00:00 +0000 wear false
         timestamp 2020-02-02 04:00:00 +0000 wear true
         timestamp 2020-02-02 06:15:00 +0000 wear false
         timestamp 2020-02-02 08:12:00 +0000 wear true
         timestamp 2020-02-15 14:38:45 +0000 wear false
         timestamp 2020-02-15 14:38:57 +0000 wear true
         timestamp 2020-02-15 14:38:59 +0000 wear false
         */
        let json_objects = [
        "{\"id\":0,\"timestamp\":1575640800000,\"wear\":false,\"time_string\":\"15:00\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":1,\"timestamp\":1575750000000,\"wear\":true,\"time_string\":\"21:20\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":2,\"timestamp\":1575753300000,\"wear\":false,\"time_string\":\"22:15\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":3,\"timestamp\":1575760500000,\"wear\":true,\"time_string\":\"00:15\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":4,\"timestamp\":1575760800000,\"wear\":false,\"time_string\":\"00:20\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":5,\"timestamp\":1575765600000,\"wear\":true,\"time_string\":\"01:40\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":6,\"timestamp\":1575790800000,\"wear\":false,\"time_string\":\"08:40\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":7,\"timestamp\":1575813600000,\"wear\":true,\"time_string\":\"15:00\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":8,\"timestamp\":1575831600000,\"wear\":false,\"time_string\":\"20:00\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":9,\"timestamp\":1575849600000,\"wear\":true,\"time_string\":\"01:00\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":10,\"timestamp\":1575853200000,\"wear\":false,\"time_string\":\"02:00\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":11,\"timestamp\":1580616000000,\"wear\":true,\"time_string\":\"05:00\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":12,\"timestamp\":1580624100000,\"wear\":false,\"time_string\":\"07:15\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":13,\"timestamp\":1580631120000,\"wear\":true,\"time_string\":\"09:12\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":14,\"timestamp\":1581777525215,\"wear\":false,\"time_string\":\"15:38\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":15,\"timestamp\":1581777537065,\"wear\":true,\"time_string\":\"15:38\",\"timezone\":{\"identifier\":\"GMT\"} }"
        ,"{\"id\":16,\"timestamp\":1581777539921,\"wear\":false,\"time_string\":\"15:38\",\"timezone\":{\"identifier\":\"GMT\"} }" ]
        
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
        
        XCTAssertEqual(test, [ intervals[1],intervals[3] ])
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
    
    func test_get_wear_timer_for_date_06() {
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
    
    func test_get_off_timer_for_date_05() {
        let day0 = dateFormatter.date(from: "2019-07-12 20:00")!
        let d00 = DayInterval(0, wear: true, time: day0)
    
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [d00]
        let provided_time = dateFormatter.date(from: "2019-07-12 21:01")

        let test = align_time.get_off_timer_for_date(update_time: provided_time)

        XCTAssertEqual(test, 0)
    }
    
    func test_get_off_timer_for_date_06() {
        let day0 = dateFormatter.date(from: "2019-07-12 20:00")!
        let day1 = dateFormatter.date(from: "2019-07-12 20:04")!
        let d00 = DayInterval(0, wear: true, time: day0)
        let d01 = DayInterval(1, wear: false, time: day1)
    
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [d00,d01]
        let provided_time = dateFormatter.date(from: "2019-07-12 20:05")

        let test = align_time.get_off_timer_for_date(update_time: provided_time)

        XCTAssertEqual(test, 60)
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

        let d01 = DayInterval(0, wear: false, time: day1)
        let d02 = DayInterval(1, wear: true, time: day2)
        let d03 = DayInterval(2, wear: false, time: day3)
    
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
    
    
    func test_days_left01() {
        let align_time:AlignTime = AlignTime()
        let day = dateFormatter.date(from: "2019-07-12 00:00")
        
        align_time.required_aligners_total = 74
        align_time.aligners_wear_days = 7
        align_time.start_treatment = day!
        align_time.aligner_number_now = 28
        align_time.days_wearing = 1
        align_time.aligners = []
        
        align_time.update_today_dates()

        let days_result = align_time.days_left
        XCTAssertEqual(days_result, "328")
    }
    
    func test_days_left02() {
        let align_time:AlignTime = AlignTime()
        let day = dateFormatter.date(from: "2019-07-12 00:00")
        
        align_time.required_aligners_total = 74
        align_time.aligners_wear_days = 7
        align_time.start_treatment = day!
        align_time.aligner_number_now = 28
        align_time.days_wearing = 1
        
        let a01:IndividualAligner = IndividualAligner(0,days:7,aligner_number:30)
        
        align_time.aligners = [a01]
        
        align_time.update_today_dates()

        let days_result = align_time.days_left
        XCTAssertEqual(days_result, "328")
    }
    
    func test_days_left03() {
        let align_time:AlignTime = AlignTime()
        let day = dateFormatter.date(from: "2019-07-12 00:00")
        
        align_time.required_aligners_total = 74
        align_time.aligners_wear_days = 7
        align_time.start_treatment = day!
        align_time.aligner_number_now = 28
        align_time.days_wearing = 1
        
        let a01:IndividualAligner = IndividualAligner(0,days:8,aligner_number:30)
        
        align_time.aligners = [a01]
        
        align_time.update_today_dates()

        let days_result = align_time.days_left
        XCTAssertEqual(days_result, "329")
    }
    
    func test_days_left04() {
        let align_time:AlignTime = AlignTime()
        let day = dateFormatter.date(from: "2019-07-12 00:00")
        
        align_time.required_aligners_total = 74
        align_time.aligners_wear_days = 7
        align_time.start_treatment = day!
        align_time.aligner_number_now = 28
        align_time.days_wearing = 1
        
        let a01:IndividualAligner = IndividualAligner(0,days:5,aligner_number:29)
        let a02:IndividualAligner = IndividualAligner(1,days:9,aligner_number:30)
        
        align_time.aligners = [a01,a02]
        
        align_time.update_today_dates()

        let days_result = align_time.days_left
        XCTAssertEqual(days_result, "328")
    }
    
    func test_days_left05() {
        let align_time:AlignTime = AlignTime()
        let day = dateFormatter.date(from: "2019-07-12 00:00")
        
        align_time.required_aligners_total = 74
        align_time.aligners_wear_days = 7
        align_time.start_treatment = day!
        align_time.aligner_number_now = 28
        align_time.days_wearing = 1
        
        let a01:IndividualAligner = IndividualAligner(0,days:3,aligner_number:34)
        let a02:IndividualAligner = IndividualAligner(1,days:9,aligner_number:35)
        
        align_time.aligners = [a01,a02]
        
        align_time.update_today_dates()

        let days_result = align_time.days_left
        XCTAssertEqual(days_result, "326")
    }
    
    func test_days_left06() {
        let align_time:AlignTime = AlignTime()
        let day = dateFormatter.date(from: "2019-07-12 00:00")
        
        align_time.required_aligners_total = 74
        align_time.aligners_wear_days = 7
        align_time.start_treatment = day!
        align_time.aligner_number_now = 28
        align_time.days_wearing = 1
        
        let a01:IndividualAligner = IndividualAligner(0,days:10,aligner_number:34)
        let a02:IndividualAligner = IndividualAligner(1,days:10,aligner_number:35)
        let a03:IndividualAligner = IndividualAligner(2,days:10,aligner_number:36)
        let a04:IndividualAligner = IndividualAligner(3,days:10,aligner_number:37)
        
        align_time.aligners = [a01,a02,a03,a04]
        
        align_time.update_today_dates()

        let days_result = align_time.days_left
        XCTAssertEqual(days_result, "340")
    }
    
    func test_expected_aligner01() {
        let align_time:AlignTime = AlignTime()
        let start_day_for_aligner = dateFormatter.date(from: "2019-07-15 00:00")
        let current_day = dateFormatter.date(from: "2019-07-24 00:00")
        
        align_time.required_aligners_total = 4
        align_time.aligners_wear_days = 10
        align_time.start_date_for_current_aligners = start_day_for_aligner!
        align_time.aligner_number_now = 1
        align_time.days_wearing = 5
        
        let a01:IndividualAligner = IndividualAligner(0,days:10,aligner_number:1)
        let a02:IndividualAligner = IndividualAligner(1,days:10,aligner_number:2)

        

        align_time.aligners = [a01,a02]

        let result = align_time.get_expected_aligner_for_date(date:current_day!)
        
        XCTAssertEqual(result, 1)
    }
    
//    func test_expected_aligner02() {
//        let align_time:AlignTime = AlignTime()
//        let start_day_for_aligner = dateFormatter.date(from: "2019-07-15 00:00")
//        let current_day = dateFormatter.date(from: "2019-07-25 00:00")
//
//        align_time.required_aligners_total = 4
//        align_time.aligners_wear_days = 10
//        align_time.start_date_for_current_aligners = start_day_for_aligner!
//        align_time.aligner_number_now = 1
//        align_time.days_wearing = 3
//
//        let a01:IndividualAligner = IndividualAligner(0,days:10,aligner_number:1)
//        let a02:IndividualAligner = IndividualAligner(1,days:10,aligner_number:2)
//
//        align_time.aligners = [a01,a02]
//
//        let result = align_time.get_expected_aligner_for_date(date:current_day!)
//
//        XCTAssertEqual(result, 1)
//    }
//
//    func test_expected_aligner03() {
//        let align_time:AlignTime = AlignTime()
//        let start_day_for_aligner = dateFormatter.date(from: "2019-07-15 00:00")
//        let current_day = dateFormatter.date(from: "2019-07-27 00:00")
//
//        align_time.required_aligners_total = 4
//        align_time.aligners_wear_days = 10
//        align_time.start_date_for_current_aligners = start_day_for_aligner!
//        align_time.aligner_number_now = 1
//        align_time.days_wearing = 3
//
//        let a01:IndividualAligner = IndividualAligner(0,days:10,aligner_number:1)
//        let a02:IndividualAligner = IndividualAligner(1,days:10,aligner_number:2)
//        let a03:IndividualAligner = IndividualAligner(2,days:10,aligner_number:3)
//        let a04:IndividualAligner = IndividualAligner(3,days:10,aligner_number:4)
//
//
//        align_time.aligners = [a01,a02,a03,a04]
//
//        let result = align_time.get_expected_aligner_for_date(date:current_day!)
//
//        XCTAssertEqual(result, 2)
//    }
    
//    func test_expected_aligner02() {
//        let align_time:AlignTime = AlignTime()
//        let start_day = dateFormatter.date(from: "2019-07-12 00:00")
//        let current_day = dateFormatter.date(from: "2019-08-10 00:00")
//
//        align_time.required_aligners_total = 5
//        align_time.aligners_wear_days = 10
//        align_time.start_treatment = start_day!
//        align_time.aligner_number_now = 1
//        align_time.days_wearing = 3
//
//        let a01:IndividualAligner = IndividualAligner(0,days:10,aligner_number:1)
//        let a02:IndividualAligner = IndividualAligner(1,days:10,aligner_number:2)
//        let a03:IndividualAligner = IndividualAligner(2,days:20,aligner_number:3)
//        let a04:IndividualAligner = IndividualAligner(3,days:10,aligner_number:4)
//        let a05:IndividualAligner = IndividualAligner(4,days:10,aligner_number:5)
//
//        align_time.aligners = [a01,a02,a03,a04,a05]
//
//        let result = align_time.get_expected_aligner_for_date(start_aligner:2,
//                                                              start_date:start_day!,
//                                                              date:current_day!)
//        XCTAssertEqual(result, 3)
//    }
    
//    func test_expected_aligner03() {
//        let align_time:AlignTime = AlignTime()
//        let start_day = dateFormatter.date(from: "2018-07-12 00:00")
//        let start_day_for_aligner = dateFormatter.date(from: "2019-07-12 00:00")
//        let current_day = dateFormatter.date(from: "2019-08-12 00:00")
//
//        align_time.required_aligners_total = 5
//        align_time.aligners_wear_days = 10
//        align_time.start_treatment = start_day!
//        align_time.aligner_number_now = 2
//        align_time.days_wearing = 3
//
//        let a01:IndividualAligner = IndividualAligner(0,days:365,aligner_number:1)
//        let a02:IndividualAligner = IndividualAligner(1,days:25,aligner_number:2)
//        let a03:IndividualAligner = IndividualAligner(2,days:20,aligner_number:3)
//        let a04:IndividualAligner = IndividualAligner(3,days:15,aligner_number:4)
//        let a05:IndividualAligner = IndividualAligner(4,days:10,aligner_number:5)
//
//        align_time.aligners = [a01,a02,a03,a04,a05]
//
//        let result = align_time.get_expected_aligner_for_date(start_aligner:align_time.aligner_number_now,
//                                                              start_date:start_day_for_aligner!,
//                                                              date:current_day!)
//        XCTAssertEqual(result, 3)
//    }
    
    
    func test_remove_interesected_events01(){
        let date1 = dateFormatter.date(from: "2019-12-06 15:00")!
        let date2 = dateFormatter.date(from: "2019-12-07 13:20")!
        let date3 = dateFormatter.date(from: "2019-12-07 14:15")!
        let date4 = dateFormatter.date(from: "2019-12-07 14:22")!
        let date5 = dateFormatter.date(from: "2019-12-07 14:50")!
        
        let date_s = dateFormatter.date(from: "2019-12-07 13:00")!
        let date_e = dateFormatter.date(from: "2019-12-07 14:25")!

        let event1 = DayInterval(0, wear: true, time: date1)
        let event2 = DayInterval(1, wear: false, time: date2)
        let event3 = DayInterval(2, wear: true, time: date3)
        let event4 = DayInterval(3, wear: false, time: date4)
        let event5 = DayInterval(4, wear: true, time: date5)
        
        event2.time = date_s
        event3.time = date_e
        
        let date_temp = dateFormatter.date(from: "2019-12-07 14:25")!
        let event_temp = DayInterval(3, wear: false, time: date_temp)
        event_temp.time = event_temp.time.advanced(by: 1)
        
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [event1,event2,event3,event4,event5]
        align_time.remove_interesected_events(event_index:1)

        let result:[DayInterval] = [event1,event2,event3,event_temp,event5]
        XCTAssertEqual(result, align_time.intervals)
    }
    
    func test_remove_interesected_events02(){
        let date0 = dateFormatter.date(from: "2019-12-06 15:00")!
        let date1 = dateFormatter.date(from: "2019-12-07 13:10")!
        let date2 = dateFormatter.date(from: "2019-12-07 13:11")!
        let date3 = dateFormatter.date(from: "2019-12-07 13:15")!
        let date4 = dateFormatter.date(from: "2019-12-07 13:20")!
        let date5 = dateFormatter.date(from: "2019-12-07 14:15")!
        let date6 = dateFormatter.date(from: "2019-12-07 14:22")!
        
        let date_s = dateFormatter.date(from: "2019-12-07 13:00")!

        let event0 = DayInterval(0, wear: true, time: date0)
        let event1 = DayInterval(1, wear: false, time: date1)
        let event2 = DayInterval(2, wear: true, time: date2)
        let event3 = DayInterval(3, wear: false, time: date3)
        let event4 = DayInterval(4, wear: true, time: date4)
        let event5 = DayInterval(5, wear: false, time: date5)
        let event6 = DayInterval(6, wear: true, time: date6)
        
        event5.time = date_s
        
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [event0,event1,event2,event3,event4,event5,event6]
        align_time.remove_interesected_events(event_index:5)

        let result:[DayInterval] = [event0,event5,event6]
        XCTAssertEqual(result, align_time.intervals)
    }
    
    func test_remove_interesected_events03(){
        let date0 = dateFormatter.date(from: "2019-07-13 15:39")!
        let date1 = dateFormatter.date(from: "2019-07-13 21:30")!
        let date2 = dateFormatter.date(from: "2019-07-13 21:30")!
        let date3 = dateFormatter.date(from: "2019-07-13 21:30")!
        let date4 = dateFormatter.date(from: "2019-07-13 21:30")!
        let date5 = dateFormatter.date(from: "2019-07-13 21:31")!
        let date6 = dateFormatter.date(from: "2019-07-13 21:31")!
        let date7 = dateFormatter.date(from: "2019-07-13 22:14")!
        let date8 = dateFormatter.date(from: "2019-07-13 23:12")!
        let date9 = dateFormatter.date(from: "2019-07-13 23:13")!
        
        let date_s = dateFormatter.date(from: "2019-07-13 21:14")!
        
        let date_temp = dateFormatter.date(from: "2019-07-13 21:14")!
        let event_temp = DayInterval(1, wear: true, time: date_temp)
        event_temp.time = event_temp.time.advanced(by: 1)

        let event0 = DayInterval(0, wear: false, time: date0)
        let event1 = DayInterval(1, wear: true, time: date1)
        let event2 = DayInterval(2, wear: false, time: date2.advanced(by: 1))
        let event3 = DayInterval(3, wear: true, time: date3.advanced(by: 2))
        let event4 = DayInterval(4, wear: false, time: date4.advanced(by: 3))
        let event5 = DayInterval(5, wear: true, time: date5)
        let event6 = DayInterval(6, wear: false, time: date6)
        let event7 = DayInterval(7, wear: true, time: date7)
        let event8 = DayInterval(8, wear: false, time: date8)
        let event9 = DayInterval(9, wear: true, time: date9)
        
        event8.time = date_s
        
        let align_time:AlignTime = AlignTime()
        align_time.intervals = [event0,event1,event2,event3,event4,event5,event6,event7,event8,event9]
        align_time.remove_interesected_events(event_index:8)

        let result:[DayInterval] = [event0,event_temp,event8,event9]
        XCTAssertEqual(result, align_time.intervals)
    }

    func testFilterPerformance() {
        let align_time:AlignTime = fill_9000_Intervals()
        let provided_time = dateFormatter.date(from: "2019-07-12 05:15")!
        measure {
            _ = align_time.get_wear_timer_for_date(update_time: provided_time)
        }
    }
}
