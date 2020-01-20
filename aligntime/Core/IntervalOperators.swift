//
//  IntervalsOperators.swift
//  aligntime
//
//  Created by Ostap on 12/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

func test_intervals()->[DayInterval2]{
    let formatter_date = DateFormatter()
    formatter_date.dateFormat = "yyyy/MM/dd hh:mm"
    let day0_2 = formatter_date.date(from: "2019/12/06 15:00")
    let day0_1 = formatter_date.date(from: "2019/12/07 21:20")
    let day0 = formatter_date.date(from: "2019/12/07 22:15")
    let day1 = formatter_date.date(from: "2019/12/08 00:15")
    let day2 = formatter_date.date(from: "2019/12/08 00:20")
    let day3 = formatter_date.date(from: "2019/12/08 01:40")
    
    let d0_2 = DayInterval2()
    d0_2.id = 0
    d0_2.time = day0_2!
    d0_2.wear = false
    
    let d0_1 = DayInterval2()
    d0_1.id = 1
    d0_1.time = day0_1!
    d0_1.wear = true
    
    let d00 = DayInterval2()
    d00.id = 2
    d00.time = day0!
    d00.wear = false
    
    let d01 = DayInterval2()
    d01.id = 3
    d01.time = day1!
    d01.wear = true
    
    let d02 = DayInterval2()
    d02.id = 4
    d02.time = day2!
    d02.wear = false
    
    let d03 = DayInterval2()
    d03.id = 5
    d03.time = day3!
    d03.wear = true
    
    return [d0_2,d0_1,d00,d01,d02,d03]
}

//func intervals_to_raw_intervals(intervals:[Day])->[DayInterval]{
//    var days:[DayInterval] = []
//    for (index,item) in intervals.enumerated(){
//        let int_date = Int(item.original_date)
//        if item.original_date == int_date{
//            let int_date = Int(item.start_time.timeIntervalSince1970)
//
//            //days.append(int_date)
//        }
//    }
//    return days
//}


func date_string_format(_ date: Date) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: date)
}
