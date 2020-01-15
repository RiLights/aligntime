//
//  IntervalsOperators.swift
//  aligntime
//
//  Created by Ostap on 12/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

func update_intrevals_order(intervals:[(key: Int, value: Bool)])->[Int: Bool]{
    var update_intrevals:[Int: Bool] = [:]

    //for (index,item) in sorted_intervals.enumerated(){

    return update_intrevals
}

func create_wear_intervals(intervals:[[Int: Bool]],type:Bool)->[Day]{
    var wear_intervals:[Day] = []
    var off_intervals:[Day] = []
    let sorted_intervals = intervals//intervals.sorted(by: { $0.0 < $1.0 } )
    //let update_intrevals = update_intrevals_order(intervals:sorted_intervals)
    var wear_temp_index = 0
    var off_temp_index = 0
    
    for (index,item) in sorted_intervals.enumerated(){
        let wear_interval = Day()
        let off_interval = Day()
        print(item.keys.first)
    
//        if item.value{
//            wear_interval.id = wear_temp_index
//            wear_interval.original_date = item.key
//            let start_date = Date(timeIntervalSince1970: Double(item.key))
//            wear_interval.start_time = start_date
//
//            var end_date = Date()
//            if sorted_intervals.count != (index+1){
//                end_date =  Date(timeIntervalSince1970: Double(sorted_intervals[index+1].key))
//                wear_interval.end_time = end_date
//            }
//            else{
//                wear_interval.current_date = true
//            }
//
//
//            wear_temp_index+=1
//            wear_intervals.append(wear_interval)
//        }
//        else{
//            off_interval.id = off_temp_index
//            off_interval.original_date = item.key
//            let start_date = Date(timeIntervalSince1970: Double(item.key))
//            off_interval.start_time = start_date
//
//            var end_date = Date()
//            if sorted_intervals.count != (index+1){
//                end_date =  Date(timeIntervalSince1970: Double(sorted_intervals[index+1].key))
//                off_interval.end_time = end_date
//            }
//            else{
//                off_interval.current_date = true
//            }
//
//            off_temp_index+=1
//            off_intervals.append(off_interval)
//        }
    }
    
    if type{
        return wear_intervals
    }
    else{
        return off_intervals
    }
}
