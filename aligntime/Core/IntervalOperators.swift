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
    let day1 = formatter_date.date(from: "2019/12/08 00:15")
    let day2 = formatter_date.date(from: "2019/12/09 00:20")
    
    let d01 = DayInterval2()
    d01.id = 0
    d01.time = day1!
    d01.wear = true
    
    let d02 = DayInterval2()
    d01.id = 1
    d02.time = day2!
    d01.wear = false
    
    return [d01,d02]
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

func update_intrevals_order(intervals:[DayInterval])->[DayInterval]{
    var updated_intrevals:[DayInterval] = []
    
    if intervals.count == 0{
        return intervals
    }
    
    var previos_state = intervals[0]

    for item in intervals{
        if item.time == previos_state.time{
            updated_intrevals.append(item)
            continue
        }
        if item.wear != previos_state.wear{
            updated_intrevals.append(item)
        }
        previos_state = item
    }

    return updated_intrevals
}

func date_string_format(_ date: Date) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: date)
}

func create_wear_intervals(intervals:[DayInterval],type:Bool)->[Day]{
    var wear_intervals:[Day] = []
    var off_intervals:[Day] = []
    //let sorted_intervals = intervals//intervals.sorted(by: { $0.0 < $1.0 } )
    let intervals = update_intrevals_order(intervals:intervals)
    var wear_temp_index = 0
    var off_temp_index = 0
    
    for (index,item) in intervals.enumerated(){
        let wear_interval = Day()
        let off_interval = Day()
    
        if item.wear{
            off_interval.state = true
            wear_interval.id = wear_temp_index
            wear_interval.original_date = item.time
            let start_date = Date(timeIntervalSince1970: Double(item.time))
            wear_interval.start_time = start_date
            
            var end_date = Date()
            if intervals.count != (index+1){
                end_date =  Date(timeIntervalSince1970: Double(intervals[index+1].time))
                wear_interval.end_time = end_date
            }
            else{
                wear_interval.current_date = true
            }
            wear_interval.day = date_string_format(start_date)!
            print(wear_interval.day)
            wear_temp_index+=1
            wear_intervals.append(wear_interval)
        }
        else{
            off_interval.state = false
            off_interval.id = off_temp_index
            off_interval.original_date = item.time
            let start_date = Date(timeIntervalSince1970: Double(item.time))
            off_interval.start_time = start_date

            var end_date = Date()
            if intervals.count != (index+1){
                end_date =  Date(timeIntervalSince1970: Double(intervals[index+1].time))
                off_interval.end_time = end_date
            }
            else{
                off_interval.current_date = true
            }

            off_temp_index+=1
            
            off_intervals.append(off_interval)
            wear_temp_index+=1
            off_interval.id = wear_temp_index
            wear_intervals.append(off_interval)
        }
    }
    
    if type{
        //let test:[DayInterval] = intervals_to_raw_intervals(intervals:wear_intervals)
        return wear_intervals
    }
    else{
        return off_intervals
    }
}
