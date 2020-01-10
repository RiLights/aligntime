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
    
    var body: some View {
        VStack (spacing:0){
            HStack{
                Spacer()
                Button(action: {
                    print("not ready yet")
                }){
                    Spacer()
                    Text("Use Next Day")
                    .padding(.horizontal,8)
                    .padding(.vertical,5)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                }
            }
            .padding(.horizontal, 5)
            
            
            DatePicker("", selection: $date_time, displayedComponents: .hourAndMinute)
                .labelsHidden()
            Text("Please select your wear time")
        }
        .font(.subheadline)
        .frame(height: 230)
    }
}
