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
    @State var intervals:[DayInterval] = []
    
    var date_formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        //formatter.dateFormat = "dd MMMM"
        return formatter
    }
    
    var body: some View {
        VStack{
            ScrollView(.vertical) {
                HStack(alignment:.top){
                    OffEvents(navigation_label:self.$navigation_label,
                                      show_modal: self.$show_modal)
                }
            }
            Divider()
//            Text("Selected Date: \(self.core_data.selected_date, formatter: date_formatter)")
//                .foregroundColor(.accentColor)
//                .font(.system(size: 15))
//                .padding(.bottom,5)
//                .animation(.none)
            Text("Total Wear Time: \(hour_timer_format(self.core_data.total_wear_time_for_date(date:self.core_data.selected_date))!)")
                .foregroundColor(.accentColor)
                .font(.system(size: 18))
                .padding(.bottom, 5)
                .animation(.none)
        }
        .sheet(isPresented: self.$show_modal) {
            IntervalEditList(navigation_label: self.$navigation_label,dismiss:self.$show_modal).environmentObject(self.core_data)
        }
    }
}

