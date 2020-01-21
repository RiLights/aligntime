//
//  WearFields.swift
//  aligntime
//
//  Created by Ostap on 10/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI


struct IntervalFields: View {
    @EnvironmentObject var core_data: AlignTime
    @State var navigation_label = "Wear Times"
    @State var show_modal = false
    
    var body: some View {
        HStack(alignment:.top){
            WearIntervals(intervals:$core_data.intervals,
                          navigation_label:self.$navigation_label,
                          show_modal: self.$show_modal)
            
            Spacer()
            OffIntervals(intervals:$core_data.intervals,
                        navigation_label:self.$navigation_label,
                        show_modal: self.$show_modal)
        }
        .sheet(isPresented: self.$show_modal) {
                IntervalEditList(navigation_label: self.$navigation_label,
                                intervals:self.$core_data.intervals).environmentObject(self.core_data)
            
        }
    }
}

