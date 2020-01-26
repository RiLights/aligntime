//
//  RKWeekdayHeader.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import SwiftUI

struct RKWeekdayHeader : View {
    @EnvironmentObject var core_data: AlignTime
     
    var body: some View {
        HStack(alignment: .center) {
            ForEach(self.getWeekdayHeaders(calendar: self.core_data.calendar), id: \.self) { weekday in
                Text(weekday)
                    .font(.system(size: 15))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(Color(UIColor.systemBackground))
            }
        }.background(core_data.colors.weekdayHeaderBackColor)
    }
    
    func getWeekdayHeaders(calendar: Calendar) -> [String] {
        let formatter = DateFormatter()
        
        var weekdaySymbols = formatter.shortStandaloneWeekdaySymbols
        let weekdaySymbolsCount = weekdaySymbols?.count ?? 0
        
        for _ in 0 ..< (1 - calendar.firstWeekday + weekdaySymbolsCount){
            let lastObject = weekdaySymbols?.last
            weekdaySymbols?.removeLast()
            weekdaySymbols?.insert(lastObject!, at: 0)
        }
        
        return weekdaySymbols ?? []
    }
}

