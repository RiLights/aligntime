//
//  WearFields.swift
//  aligntime
//
//  Created by Ostap on 10/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct WearFields: View {
    @EnvironmentObject var core_data: AlignTime
    @State var navigation_label = "Wear Times"
    @State var show_modal = false
    
    
    var body: some View {
        HStack(alignment:.top){
            Button(action: {
                self.navigation_label = "Wear Times"
                self.show_modal.toggle()
            }) {
                VStack{
                    Text("Wear Times:")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 21))
                    ForEach(core_data.wear_intervals) { i in
                        Text("\(i.start_time_string)-\(i.end_time_string)")
                            .font(.system(size: 18))
                            .fontWeight(.light)
                            .foregroundColor(.accentColor)
                    }
                }
            }
            Spacer()
            Button(action: {
                self.navigation_label = "Off Times"
                self.show_modal.toggle()
            }) {
                VStack(alignment:.center){
                    Text("Off Times:")
                        .foregroundColor(.red)
                        .font(.system(size: 21))
                    ForEach(core_data.day_intervals) { i in
                        Text("\(i.start_time_string)-\(i.end_time_string)")
                            .font(.system(size: 18))
                            .fontWeight(.light)
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .sheet(isPresented: self.$show_modal) {
            WearEditFields(navigation_label: self.$navigation_label,intervals:self.$core_data.wear_intervals).environmentObject(self.core_data)
        }
    }
}
