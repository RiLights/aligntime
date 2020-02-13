//
//  DateExtension.swift
//  aligntime
//
//  Created by Ostap on 12/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

extension Date {
    public func setTime(hour: Int, min: Int, sec: Int) -> Date? {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)
        components.timeZone = .current
        components.hour = hour
        components.minute = min
        components.second = sec

        return cal.date(from: components)
    }
    
    public func belongTo(date: Date, toGranularity: Calendar.Component = .day) -> Bool {
       return (Calendar.current.isDate(self, inSameDayAs: date))
    }
       
    public func isCurrent() -> Bool {
        return (Calendar.current.isDate(self, equalTo: Date(), toGranularity: .day))
    }
    
    public func addDay(value: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: value, to: self)!
    }
    
    func timestamp() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
