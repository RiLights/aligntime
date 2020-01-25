//
//  test_data.swift
//  aligntime
//
//  Created by Ostap on 22/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation

func test_intervals()->[DayInterval]{
    let formatter_date = DateFormatter()
    formatter_date.dateFormat = "yyyy/MM/dd HH:mm"
    let day0_2 = formatter_date.date(from: "2019/12/06 15:00")
    let day0_1 = formatter_date.date(from: "2019/12/07 21:20")
    let day0 = formatter_date.date(from: "2019/12/07 22:15")
    let day1 = formatter_date.date(from: "2019/12/08 00:15")
    let day2 = formatter_date.date(from: "2019/12/08 00:20")
    let day3 = formatter_date.date(from: "2019/12/08 01:40")
    let day4 = formatter_date.date(from: "2019/12/08 08:40")
    let day5 = formatter_date.date(from: "2019/12/08 15:00")
    let day6 = formatter_date.date(from: "2019/12/08 20:00")
    let day7 = formatter_date.date(from: "2019/12/09 01:00")
    let day8 = formatter_date.date(from: "2019/12/09 02:00")
    
    let d0_2 = DayInterval()
    d0_2.id = 0
    d0_2.time = day0_2!
    d0_2.wear = false
    
    
    let d0_1 = DayInterval()
    d0_1.id = 1
    d0_1.time = day0_1!
    d0_1.wear = true
    
    let d00 = DayInterval()
    d00.id = 2
    d00.time = day0!
    d00.wear = false
    
    let d01 = DayInterval()
    d01.id = 3
    d01.time = day1!
    d01.wear = true
    
    let d02 = DayInterval()
    d02.id = 4
    d02.time = day2!
    d02.wear = false
    
    let d03 = DayInterval()
    d03.id = 5
    d03.time = day3!
    d03.wear = true
    
    let d04 = DayInterval()
    d04.id = 6
    d04.time = day4!
    d04.wear = false
    
    let d05 = DayInterval()
    d05.id = 7
    d05.time = day5!
    d05.wear = true
    
    let d06 = DayInterval()
    d06.id = 8
    d06.time = day6!
    d06.wear = false
    
    let d07 = DayInterval()
    d07.id = 9
    d07.time = day7!
    d07.wear = true
    
    let d08 = DayInterval()
    d08.id = 10
    d08.time = day8!
    d08.wear = false

    
    return [d0_2,d0_1,d00,d01,d02,d03,d04,d05,d06,d07,d08]
}
