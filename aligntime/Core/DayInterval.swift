//
//  DayInterval.swift
//  aligntime
//
//  Created by Ostap on 10/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation


class DayInterval: Identifiable,ObservableObject {
    var id: Int = 0
    var time_string: String = "...."
    var wear:Bool = true
    var day:String = ""

    @Published var time:Date = Date() {
        didSet {
            self.time_string = clock_string_format(self.time)!
        }
    }
}

