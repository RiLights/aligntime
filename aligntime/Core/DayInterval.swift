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
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: date)
}


class DayInterval: Identifiable,ObservableObject,Comparable {
    var id: Int = 0
    var time_string: String = "...."
    var wear:Bool = true
    var day:String = ""
    var timestamp: Int64 = 0
    
    init() {}
    init(_ id: Int, wear: Bool, time: Date ) {
        self.timestamp = time.timestamp()
        self.wear = wear
        self.time = time
        self.id = id
    }

    @Published var time:Date = Date() {
        didSet {
            self.timestamp = time.timestamp()
            self.time_string = clock_string_format(self.time)!
        }
    }
    
    static func <(lhs: DayInterval, rhs: DayInterval) -> Bool {
        return lhs.id < rhs.id
    }
    
    static func == (lhs: DayInterval, rhs: DayInterval) -> Bool {
        return lhs.id == rhs.id
    }
}

