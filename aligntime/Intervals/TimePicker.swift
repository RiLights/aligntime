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
    @Binding var event_id:Int
    
    func get_min_time(_ id:Int)->Date{
        print("sdf",id)
        if id >= 0{
            return self.core_data.intervals[id].time
        }
        return get_1970()
    }
    
    func get_max_time(_ id:Int)->Date{
        if id < self.core_data.intervals.count{
            return self.core_data.intervals[id].time
        }
        return Date()
    }
    
    var body: some View {
        VStack (spacing:0){
            Spacer()
            HStack{
                Text(NSLocalizedString("Start Time",comment:""))
                    .padding()
                Spacer()
            }
            DatePicker("", selection: self.$core_data.intervals[event_id].time,
                       in: self.get_min_time(event_id-1)...self.get_max_time(event_id+1),
                       displayedComponents: .hourAndMinute)
                .labelsHidden()
            Divider()
            HStack{
                Text(NSLocalizedString("End Time",comment:""))
                    .padding()
                Spacer()
            }
            if (self.core_data.intervals.count<=self.event_id+1){
                 Text(NSLocalizedString("Now",comment:""))
                    .font(.title)
                    .padding(40)
            }
            else{
                DatePicker("", selection: self.$core_data.intervals[event_id+1].time,
                           in: self.get_min_time(event_id)...self.get_max_time(event_id+2),
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
                        .font(.body)
                }
            }
        }
    }
}
