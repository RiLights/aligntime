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
    @Binding var date_time:Date
    @Binding var selected_id:Int
    @Binding var min_time:Date
    @Binding var max_time:Date
    @Binding var dismiss:Bool
    
    var body: some View {
        VStack (spacing:0){
            Spacer()
            HStack{
                Text("Start Time")
                    .padding()
                Spacer()
            }
            DatePicker("", selection: $date_time,
                       in: min_time...max_time,
                       displayedComponents: .hourAndMinute)
                .labelsHidden()
            Divider()
            HStack{
                Text("End Time")
                    .padding()
                Spacer()
            }
            //Text(". .")
            if (self.core_data.intervals.count<=selected_id+1){
                 Text("Now")
                    .font(.title)
                    .padding(40)
             }
            else{
                DatePicker("", selection: self.$core_data.intervals[selected_id+1].time,
                           in: min_time...max_time,
                           displayedComponents: .hourAndMinute)
                    .labelsHidden()
             }
//            Text(". .")
//            Text("End")
//            DatePicker("", selection: $date_time,
//                       in: min_time...max_time,
//                       displayedComponents: .hourAndMinute)
//                .labelsHidden()
//            Text("Please select your off time interval")
//                .font(.subheadline)
//                .padding()
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
        //.font(.subheadline)
        //.frame(height: 230)
    }
}
