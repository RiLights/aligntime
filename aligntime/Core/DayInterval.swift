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
    formatter.timeStyle = .short
    return formatter.string(from: date)
}


class DayInterval: Identifiable,ObservableObject,Comparable,Codable {
    var id: Int = 0
    var time_string: String = "...."
    var wear:Bool = true
    var timestamp: Int64 = 0
    var timezone: TimeZone = .current

    
    init(){}
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        wear = try values.decode(Bool.self, forKey: .wear)
        timestamp = try values.decode(Int64.self, forKey: .timestamp)
        time = Date().fromTimestamp(timestamp)
        timezone = try values.decode(TimeZone.self, forKey: .timezone)
    }
    
    init(_ id: Int, wear: Bool, time: Date ) {
        self.timestamp = time.timestamp()
        self.wear = wear
        self.time = time
        self.id = id
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case timestamp
        case wear
        case timezone
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
    
    public func belongTo(_ date:Date) -> Bool {
        let test = Date().fromTimestamp(self.timestamp).convertToTimeZone(initTimeZone: .current, timeZone: self.timezone)
        return test.belongTo(date: date)
    }
}
