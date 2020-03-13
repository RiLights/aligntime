//
//  TimerPicker.swift
//  aligntime
//
//  Created by Ostap on 10/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI


struct TimePicker2: View {
    @EnvironmentObject var core_data: AlignTime
    var event_id:Int = 0
    
    var body: some View {
        VStack (spacing:0){
            Spacer()
            HStack{
                Text("Start Time")
                    .padding()
                Spacer()
            }
            if (self.core_data.intervals.count > self.event_id){
                DatePicker("", selection: self.$core_data.intervals[event_id].time,
                           in: ...Date(),
                           displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }
            Divider()
        }
    }
}
