//
//  RKMonth.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import SwiftUI

struct RKMonth: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var core_data: AlignTime
    
    let monthOffset: Int
    
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    let daysPerWeek = 7
    var monthsArray: [[Date]] {
        monthArray()
    }
    let cellWidth = CGFloat(32)
    
    @State var showTime = false
    
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 10){
            VStack(alignment: .leading, spacing: 5) {
                ForEach(monthsArray, id:  \.self) { row in
                    HStack() {
                        ForEach(row, id:  \.self) { column in
                            HStack() {
                                Spacer()
                                if self.isThisMonth(date: column) {
                                    RKCell(rkDate: RKDate(
                                            date: column,
                                            core: self.core_data,
                                            isDisabled: !self.isEnabled(date: column),
                                            isToday: self.isToday(date: column),
                                            isSelected: self.isSpecialDate(date: column),
                                            isBetweenStartAndEnd: self.isBetweenStartAndEnd(date: column)),
                                        cellWidth: self.cellWidth)
                                        .onTapGesture { self.dateTapped(date: column) }
                                } else {
                                    Text("")
                                        .frame(width: self.cellWidth, height: self.cellWidth)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
        }.background(core_data.colors.monthBackColor)
    }

     func isThisMonth(date: Date) -> Bool {
         return self.core_data.calendar.isDate(date, equalTo: firstOfMonthForOffset(), toGranularity: .month)
     }
    
    func dateTapped(date: Date) {
        if self.isEnabled(date: date) {
            //print("dateTapped")
            self.core_data.selected_date = date
        }
    }
    
    func monthArray() -> [[Date]] {
        var rowArray = [[Date]]()
        for row in 0 ..< (numberOfDays(offset: monthOffset) / 7) {
            var columnArray = [Date]()
            for column in 0 ... 6 {
                let abc = self.getDateAtIndex(index: (row * 7) + column)
                columnArray.append(abc)
            }
            rowArray.append(columnArray)
        }
        return rowArray
    }
    
    func getMonthHeader() -> String {
        let headerDateFormatter = DateFormatter()
        headerDateFormatter.calendar = core_data.calendar
        headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy LLLL", options: 0, locale: core_data.calendar.locale)
        
        return headerDateFormatter.string(from: firstOfMonthForOffset()).uppercased()
    }
    
    func getDateAtIndex(index: Int) -> Date {
        let firstOfMonth = firstOfMonthForOffset()
        let weekday = core_data.calendar.component(.weekday, from: firstOfMonth)
        var startOffset = weekday - core_data.calendar.firstWeekday
        startOffset += startOffset >= 0 ? 0 : daysPerWeek
        var dateComponents = DateComponents()
        dateComponents.day = index - startOffset
        
        return core_data.calendar.date(byAdding: dateComponents, to: firstOfMonth)!
    }
    
    func numberOfDays(offset : Int) -> Int {
        let firstOfMonth = firstOfMonthForOffset()
        let rangeOfWeeks = core_data.calendar.range(of: .weekOfMonth, in: .month, for: firstOfMonth)
        
        return (rangeOfWeeks?.count)! * daysPerWeek
    }
    
    func firstOfMonthForOffset() -> Date {
        var offset = DateComponents()
        offset.month = monthOffset
        
        return core_data.calendar.date(byAdding: offset, to: RKFirstDateMonth())!
    }
    
    func RKFormatDate(date: Date) -> Date {
        let components = core_data.calendar.dateComponents(calendarUnitYMD, from: date)
        
        return core_data.calendar.date(from: components)!
    }
    
    func RKFormatAndCompareDate(date: Date, referenceDate: Date) -> Bool {
        let refDate = RKFormatDate(date: referenceDate)
        let clampedDate = RKFormatDate(date: date)
        return refDate == clampedDate
    }
    
    func RKFirstDateMonth() -> Date {
        var components = core_data.calendar.dateComponents(calendarUnitYMD, from: core_data.minimumDate)
        components.day = 1
        
        return core_data.calendar.date(from: components)!
    }
    
    // MARK: - Date Property Checkers
    
    func isToday(date: Date) -> Bool {
        return RKFormatAndCompareDate(date: date, referenceDate: Date())
    }
     
    func isSpecialDate(date: Date) -> Bool {
        return     isStartDate(date: date)
                || isEndDate(date: date)
                || isSelectedDate(date: date)
    }

    func isSelectedDate(date: Date) -> Bool {
        if core_data.selected_date == nil {
            return false
        }
        return RKFormatAndCompareDate(date: date, referenceDate: core_data.selected_date)
    }
 
    
    func isStartDate(date: Date) -> Bool {
        if core_data.startDate == nil {
            return false
        }
        return RKFormatAndCompareDate(date: date, referenceDate: core_data.startDate)
    }
    
    func isEndDate(date: Date) -> Bool {
        if core_data.endDate == nil {
            return false
        }
        return RKFormatAndCompareDate(date: date, referenceDate: core_data.endDate)
    }
    
    func isBetweenStartAndEnd(date: Date) -> Bool {
        if core_data.startDate == nil {
            return false
        } else if core_data.endDate == nil {
            return false
        } else if core_data.calendar.compare(date, to: core_data.startDate, toGranularity: .day) == .orderedAscending {
            return false
        } else if core_data.calendar.compare(date, to: core_data.endDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return true
    }
    
    func isEnabled(date: Date) -> Bool {
        let clampedDate = RKFormatDate(date: date)
        if core_data.calendar.compare(clampedDate, to: core_data.minimumDate, toGranularity: .day) == .orderedAscending || core_data.calendar.compare(clampedDate, to: core_data.maximumDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return true
    }
    
    func isStartDateAfterEndDate() -> Bool {
        if core_data.startDate == nil {
            return false
        } else if core_data.endDate == nil {
            return false
        } else if core_data.calendar.compare(core_data.endDate, to: core_data.startDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return true
    }
}

