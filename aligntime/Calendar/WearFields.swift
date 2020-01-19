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

            WearIntervals(intervals:$core_data.intervals,show_modal: self.$show_modal)
            
            Spacer()
            Button(action: {
                self.navigation_label = "Off Times"
                self.show_modal.toggle()
            }) {
                VStack(alignment:.center){
                    Text("Off Times:")
                        .foregroundColor(.red)
                        .font(.system(size: 21))
                    ForEach(core_data.off_intervals) { i in
                        Text("\(i.start_time_string)-\(i.end_time_string)")
                            .font(.system(size: 18))
                            .fontWeight(.light)
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .sheet(isPresented: self.$show_modal) {
            if (self.navigation_label=="Off Times"){
                WearEditFields(navigation_label: self.$navigation_label,intervals:self.$core_data.off_intervals).environmentObject(self.core_data)
            }
            else{
                WearEditFields2(navigation_label: self.$navigation_label,intervals:self.$core_data.intervals)
            }
        }
    }
}

struct WearIntervals: View {
    @Binding var intervals:[DayInterval2]
    @State var navigation_label = "Wear Times"
    @Binding var show_modal:Bool
    
    
    var body: some View {
        Button(action: {
            self.show_modal.toggle()
        }) {
            VStack{
                Text("Wear Times:")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 21))
                HStack{
                    ForEach(intervals.filter{$0.wear == true} ) { i in
                        Text("\(i.time_string )")
                            .font(.system(size: 18))
                            .fontWeight(.light)
                            .foregroundColor(.accentColor)
                    }
                    Text("-")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 21))
                    ForEach(intervals.filter{$0.wear == false} ) { i in
                        Text("\(i.time_string )")
                            .font(.system(size: 18))
                            .fontWeight(.light)
                            .foregroundColor(.accentColor)
                    }
                }
            }
        }
    }
}
