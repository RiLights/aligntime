//
//  WearFields.swift
//  aligntime
//
//  Created by Ostap on 10/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct WearFields: View {
    @State private var show_modal = false
    @EnvironmentObject var core_data: AlignTime
    
    
    var body: some View {
        HStack{
            VStack{
                Text("Wear Times:")
                    .foregroundColor(.blue)
                    .font(.system(size: 21))
                //ForEach((1...12).reversed(), id: \.self) {
                    Text("00:00-7:00")
                        .font(.system(size: 18))
                        .fontWeight(.light)
                        .foregroundColor(.blue)
                    Text("07:30-12:00")
                        .font(.system(size: 18))
                        .fontWeight(.light)
                        .foregroundColor(.blue)
                //}
            }
            Spacer()
            Button(action: {self.show_modal.toggle()
                //print(self.core_data.aligner_number_now)
            }) {
                VStack{
                    Text("Off Times:")
                        .foregroundColor(.red)
                        .font(.system(size: 21))
                    ForEach(core_data.day_intervals.reversed()) { i in
                        Text("\(i.start_time_string)-\(i.end_time_string)")
                            .font(.system(size: 18))
                            .fontWeight(.light)
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .sheet(isPresented: self.$show_modal) {
            WearEditFields().environmentObject(self.core_data)
        }
    }
}
