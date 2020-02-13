//
//  test_data2.swift
//  aligntime
//
//  Created by Ostap on 13/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

func test_intervals2()->[DayInterval]{
    let formatter_date = DateFormatter()
    formatter_date.dateFormat = "yyyy/MM/dd HH:mm"
    
    let day0 = formatter_date.date(from: "2019-12-11 20:00")!
    let day1 = formatter_date.date(from: "2019-12-12 20:00")!
    
    let d00 = DayInterval(0, wear: true, time: day0)
    let d01 = DayInterval(1, wear: false, time: day1)
    
    return [d00,d01]
}
