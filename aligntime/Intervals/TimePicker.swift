//
//  TimerPicker.swift
//  aligntime
//
//  Created by Ostap on 10/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI


struct TimePicker: View {
    @EnvironmentObject var core_data: AlignTime
    @Binding var dismiss:Bool
    var event_id:Int = 0
    
    var body: some View {
        VStack (spacing:0){
            Spacer()
            HStack{
                Text("Start Time")
                    .padding()
                Spacer()
            }
            if (self.core_data.intervals.count > self.event_id+1){
                DatePicker("", selection: self.$core_data.intervals[event_id].time,
                           in: ...self.core_data.intervals[event_id+1].time,
                           displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }
            else if (self.core_data.intervals.count > self.event_id){
                DatePicker("", selection: self.$core_data.intervals[event_id].time,
                           in: ...Date(),
                           displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }
            Divider()
            HStack{
                Text("End Time")
                    .padding()
                Spacer()
            }
            if (self.core_data.intervals.count<=self.event_id+1){
                 Text("Now")
                    .font(.title)
                    .padding(40)
            }
            else{
                DatePicker("", selection: self.$core_data.intervals[event_id+1].time,
                           in: self.core_data.intervals[event_id].time...Date(),
                           displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }
            Spacer()
            Button(action: {
                self.dismiss = false
            }){
                ZStack(alignment: .center){
                    Rectangle()
                        .frame(height: 35)
                        .foregroundColor(Color.blue)
                    Text("Return")
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}
