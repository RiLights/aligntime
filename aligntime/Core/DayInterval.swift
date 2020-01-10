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

class Day: Identifiable,ObservableObject {
    var id: Int = 0
    var start_time_string: String = ""
    var end_time_string: String = ""
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
