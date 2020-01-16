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
    var max_time:Date = Date()
    var original_date:Int = 0
    @Published var current_date:Bool = false {
        didSet {
            self.end_time_string = "Now"
        }
    }
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

struct DayInterval{
    var wear:Bool
    var time:Int
}

