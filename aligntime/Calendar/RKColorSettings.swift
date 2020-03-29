//
//  RKColorSettings.swift
//  RKCalendar
//
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class RKColorSettings : ObservableObject {

    // foreground colors
    @Published var textColor: Color = Color.white
    @Published var todayColor: Color = Color(UIColor.systemBackground)
    @Published var selectedColor: Color = Color.white
    @Published var disabledColor: Color = Color.white
    @Published var betweenStartAndEndColor: Color = Color.red
    // background colors
    @Published var textBackColor: Color = Color.clear
    @Published var todayBackColor: Color = Color.secondary.opacity(0.1)
    @Published var selectedBackColor: Color = Color.secondary.opacity(0.3)
    @Published var disabledBackColor: Color = Color.clear
    @Published var betweenStartAndEndBackColor: Color = Color.blue
    // headers foreground colors
    @Published var weekdayHeaderColor: Color = Color.white
    @Published var monthHeaderColor: Color = Color.white
    // headers background colors
    @Published var weekdayHeaderBackColor: Color = Color.clear
    @Published var monthBackColor: Color = Color.clear

}
