//
//  RKMonth.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import SwiftUI

struct RKMonth: View {
    @EnvironmentObject var core_data: AlignTime
    
    var cell_text_color = Color.accentColor
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
                                            isSelected: self.isSpecialDate(date: column)),
                                        cellWidth: self.cellWidth,
                                        rim_color: self.rim_color(date: column),
                                        cell_text_color: self.cell_text_color,
                                        dot_color: self.dot_color(date: column))
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
    
    func dot_color(date: Date)->Color{
        let (aligner,aligner_day) = self.core_data.get_expected_aligner_for_date(date:Calendar.current.startOfDay(for:date))

        if self.core_data.is_last_day_for_aligner(aligner:aligner,
                                                  day_count:aligner_day){
            if (aligner)==self.core_data.required_aligners_total{
                
                return Color.orange
                
            }
            //if aligner==self.core_data.required_aligners_total{ return Color.clear }
            return self.cell_text_color
        }
        return Color.clear
    }
    
    func rim_color(date: Date)->Color{
        
        if self.isEnabled(date: date){
            if !self.isToday(date: date){
                if Int(self.core_data.total_wear_time_for_date(date:date))<((Int(self.core_data.wear_hours)*60*60)-1){
                    return Color.orange
                }
            }
        }
        
        return Color.clear
    }

     func isThisMonth(date: Date) -> Bool {
         return self.core_data.calendar.isDate(date, equalTo: firstOfMonthForOffset(), toGranularity: .month)
     }
    
    func dateTapped(date: Date) {
        if self.isEnabled(date: date) {
            self.core_data.selected_date = date
        }
    }
    
    func monthArray() -> [[Date]] {
        let firstOfMonth = firstOfMonthForOffset()
        let rangeOfWeeks = core_data.calendar.range(of: .weekOfMonth, in: .month, for: firstOfMonth)
        
        let numberOfDays = (rangeOfWeeks?.count)! * daysPerWeek
        
        var rowArray = [[Date]]()
        for row in 0 ..< (numberOfDays / 7) {
            var columnArray = [Date]()
            for column in 0 ... 6 {
                let abc = self.getDateAtIndex(index: (row * 7) + column)
                columnArray.append(abc)
            }
            rowArray.append(columnArray)
        }
        return rowArray
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
    
    func firstOfMonthForOffset() -> Date {
        var offset = DateComponents()
        offset.month = monthOffset
        
        var components = core_data.calendar.dateComponents(calendarUnitYMD, from: first_date_for_year())
        components.day = 1
        
        let first_month = core_data.calendar.date(from: components)!
        
        return core_data.calendar.date(byAdding: offset, to: first_month)!
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
    
    func isEnabled(date: Date) -> Bool {
        let clampedDate = RKFormatDate(date: date)
        return self.is_present(clampedDate)
    }
    
    func is_present(_ date: Date) -> Bool {
        if self.core_data.calendar.compare(date, to: self.core_data.minimumDate, toGranularity: .day) == .orderedAscending || self.core_data.calendar.compare(date, to: self.core_data.maximumDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return true
    }
}

