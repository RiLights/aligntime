//
//  IntervalsOperators.swift
//  aligntime
//
//  Created by Ostap on 12/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

func intervals_to_raw_intervals(intervals:[Day])->[DayInterval]{
    var days:[DayInterval] = []
    for (index,item) in intervals.enumerated(){
        let int_date = Int(item.original_date)
        if item.original_date == int_date{
            let int_date = Int(item.start_time.timeIntervalSince1970)
            
            //days.append(int_date)
        }
    }
    return days
}

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


            wear_temp_index+=1
            wear_intervals.append(wear_interval)
        }
        else{
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
        }
    }
    
    if type{
        let test:[DayInterval] = intervals_to_raw_intervals(intervals:wear_intervals)
        return wear_intervals
    }
    else{
        return off_intervals
    }
}
