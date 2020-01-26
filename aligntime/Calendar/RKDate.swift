//
//  RKDate.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import SwiftUI

struct RKDate {
    var date: Date
    let core: AlignTime
    
    var isDisabled: Bool = false
    var isToday: Bool = false
    var isSelected: Bool = false
    var isBetweenStartAndEnd: Bool = false
    
    init(date: Date, core: AlignTime, isDisabled: Bool, isToday: Bool, isSelected: Bool, isBetweenStartAndEnd: Bool) {
        self.date = date
        self.core = core
        self.isDisabled = isDisabled
        self.isToday = isToday
        self.isSelected = isSelected
        self.isBetweenStartAndEnd = isBetweenStartAndEnd
    }
    
    func getText() -> String {
        let day = formatDate(date: date, calendar: self.core.calendar)
        return day
    }
    
    func getTextColor() -> Color {
        var textColor = Color(UIColor.systemBackground)
        if isDisabled {
            textColor = Color(UIColor.systemBackground)
        } else if isSelected {
            textColor = Color(UIColor.systemBackground)
        } else if isToday {
            textColor = core.colors.todayColor
        } else if isBetweenStartAndEnd {
            textColor = core.colors.betweenStartAndEndColor
        }
        return textColor
    }
    
    func getBackgroundColor() -> Color {
        var backgroundColor = core.colors.textBackColor
        if isBetweenStartAndEnd {
            backgroundColor = core.colors.betweenStartAndEndBackColor
        }
        if isToday {
            backgroundColor = core.colors.todayBackColor
        }
        if isDisabled {
            backgroundColor = core.colors.disabledBackColor
        }
        if isSelected {
            backgroundColor = core.colors.selectedBackColor
        }
        return backgroundColor
    }
    
    func getFontWeight() -> Font.Weight {
        var fontWeight = Font.Weight.medium
        if isDisabled {
            fontWeight = Font.Weight.thin
        } else if isSelected {
            fontWeight = Font.Weight.heavy
        } else if isToday {
            fontWeight = Font.Weight.medium
        } else if isBetweenStartAndEnd {
            fontWeight = Font.Weight.regular
        }
        return fontWeight
    }
    
    // MARK: - Date Formats
    
    func formatDate(date: Date, calendar: Calendar) -> String {
        let formatter = dateFormatter()
        return stringFrom(date: date, formatter: formatter, calendar: calendar)
    }
    
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "d"
        return formatter
    }
    
    func stringFrom(date: Date, formatter: DateFormatter, calendar: Calendar) -> String {
        if formatter.calendar != calendar {
            formatter.calendar = calendar
        }
        return formatter.string(from: date)
    }
}

