//
//  DayInterval.swift
//  aligntime
//
//  Created by Ostap on 10/01/20.
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

class Day: Identifiable,ObservableObject { //IntervalRepresentation
    var id: Int = 0
    var start_time_string: String = "     ...."
    var end_time_string: String = "....     "
    var min_time:Date = get_min_time()
    var max_time:Date = get_max_time()
    @Published var end_time:Date = Date() {
       didSet {
           self.end_time_string = clock_string_format(self.end_time)!
       }
   }

    @Published var start_time:Date = Date() {
        didSet {
            self.start_time_string = clock_string_format(self.start_time)!
        }
    }
}

func create_test_intervals()->[Day]{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    let date_01s = formatter.date(from: "2020/01/01 00:30")
    let date_01e = formatter.date(from: "2020/01/01 07:30")
    let date_02s = formatter.date(from: "2020/01/01 13:00")
    let date_02e = formatter.date(from: "2020/01/01 15:00")
    
    let day_interval01 = Day()
    day_interval01.id = 0
    day_interval01.start_time = date_01s!
    day_interval01.end_time = date_01e!
    
    let day_interval02 = Day()
    day_interval01.id = 1
    day_interval02.start_time = date_02s!
    day_interval02.end_time = date_02e!
    return [day_interval02,day_interval01]
}

struct DayInterval{
    var wear:Bool
    var time:Int
}

func get_dates_from_interval()->[Date]{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    
    let date_01s = formatter.date(from: "2020/01/01 00:30")!
    let date_01e = formatter.date(from: "2020/01/01 07:30")!
    let date_02s = formatter.date(from: "2020/01/01 13:00")!
    
    return [date_01s,date_01e,date_02s]
}

func convert_to_date(day_interval:DayInterval)->Date{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    
    let date = formatter.date(from: "2020/01/01 00:00")!
    let time_date = date.addingTimeInterval(TimeInterval(day_interval.time))
    //print(time_date)
    return time_date
}

func convert_to_off_groups_dates(day_intervals:[DayInterval])->[[Date?]]{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    var previos_date:Date?

    var date_groups:[[Date?]] = []
    
    for (index,item) in day_intervals.enumerated(){
        let date = convert_to_date(day_interval:item)
        var date_group:[Date?] = [previos_date,date]
        if item.wear == false{
            let temp_date = convert_to_date(day_interval: day_intervals[index+1])
            date_group = [date,temp_date]
        }
        //print(date)
        previos_date = date
        date_groups.append(date_group)
        
    }
    
    let date_01s = formatter.date(from: "2020/01/01 00:30")
    let date_01e = formatter.date(from: "2020/01/01 07:30")
    let date_02s = formatter.date(from: "2020/01/01 13:00")
    
    let gr = [[nil,date_01s],[date_01e,date_02s]]
    //print(gr)
    return gr
    return date_groups
}
func create_off_intervals(day_intervals:[DayInterval])->[Day]{

    //let dt = get_dates_from_interval()
    let gr = convert_to_off_groups_dates(day_intervals:day_intervals)
    var day_intervals:[Day] = []

    for (index,item) in gr.enumerated(){
        let day_interval = Day()
        day_interval.id = index
        if item[0] != nil{
            day_interval.start_time = item[0]!
        }
        if (item[1] != nil){
            day_interval.end_time = item[1]!

        }
        
        day_intervals.append(day_interval)
    }

    return day_intervals
}
