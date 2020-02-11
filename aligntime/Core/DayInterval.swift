//
//  DayInterval.swift
//  aligntime
//
//  Created by Ostap on 10/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation


class DayInterval: Identifiable,ObservableObject,Comparable {
    var id: Int = 0
    var time_string: String = "...."
    var wear:Bool = true
    var day:String = ""
    
    init() {}
    init(id: Int, wear: Bool, time: Date) {
        self.id = id
        self.wear = wear
        self.time = time
    }

    @Published var time:Date = Date() {
        didSet {
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

