//
//  IntervalsOperators.swift
//  aligntime
//
//  Created by Ostap on 12/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

func clock_string_format(_ date: Date) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm"
    return formatter.string(from: date)
}

func get_min_time()->Date{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    return formatter.date(from: "1970/01/01")!
}

func get_max_time()->Date{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    return formatter.date(from: "3000/01/01")!
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
