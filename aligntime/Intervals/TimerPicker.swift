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
    @Binding var start_time:Date
    @Binding var end_time:Date
    @Binding var dismiss:Bool
    @State var is_now_time:Bool = false
    
    var body: some View {
        VStack (spacing:0){
            Spacer()
            HStack{
                Text("Start Time")
                    .padding()
                Spacer()
            }
            DatePicker("", selection: self.$start_time,
                       in: ...self.end_time,
                       displayedComponents: .hourAndMinute)
                .labelsHidden()
            Divider()
            HStack{
                Text("End Time")
                    .padding()
                Spacer()
            }
            if (is_now_time){
                 Text("Now")
                    .font(.title)
                    .padding(40)
             }
            else{
                DatePicker("", selection: self.$end_time,
                           in: self.start_time...Date(),
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
