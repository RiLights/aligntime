//
//  IntervalsOperators.swift
//  aligntime
//
//  Created by Ostap on 12/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation


func create_wear_intervals(intervals:[Int: Bool])->[Day]{
    var day_intervals:[Day] = []
    let sorted_intervals = intervals.sorted(by: { $0.0 < $1.0 } )
    var temp_index = 0
    
    for (index,item) in sorted_intervals.enumerated(){
        let day_interval = Day()
        
        if item.value{
            day_interval.id = temp_index
            let start_date = Date(timeIntervalSince1970: Double(item.key))
            day_interval.start_time = start_date
            
            var end_date = Date()
            if sorted_intervals.count != (index+1){
                end_date =  Date(timeIntervalSince1970: Double(sorted_intervals[index+1].key))
            }
            
            day_interval.end_time = end_date
            temp_index+=1
            day_intervals.append(day_interval)
        }
    }
    
    return day_intervals
}
