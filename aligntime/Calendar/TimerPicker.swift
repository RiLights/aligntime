//
//  TimerPicker.swift
//  aligntime
//
//  Created by Ostap on 10/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI



struct TimePicker: View {
    @Binding var date_time:Date
    @Binding var min_time:Date
    @Binding var max_time:Date
    
    var body: some View {
        VStack (spacing:0){
            DatePicker("", selection: $date_time,
                       in: min_time...max_time,
                       displayedComponents: .hourAndMinute)
                .labelsHidden()
            Text("Please select your wear time")
        }
        .font(.subheadline)
        .frame(height: 230)
    }
}
