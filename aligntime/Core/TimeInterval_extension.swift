//
//  TimeInterval_extension.swift
//  aligntime
//
//  Created by Ostap on 7/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

extension TimeInterval {

    var minutes: Int {
        return (Int(self) / 60 ) % 60
    }

    var hours: Int {
        return Int(self) / 3600
    }
    
    var days: Int {
        return Int(self) / 86400
    }
}
