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
    
    var body: some View {
        VStack{
            ScrollView(.vertical) {
                HStack(alignment:.top){
                    OffEvents(navigation_label:self.$navigation_label,
                                      show_modal: self.$show_modal)
                }
            }
            Divider()
            Text("Total Wear Time: \(hour_timer_format(total_wear_time())!)")
                .foregroundColor(.accentColor)
                .font(.system(size: 18))
                .padding(.bottom, 5)
                .animation(.none)
        }
        .sheet(isPresented: self.$show_modal) {
            IntervalEditList(navigation_label: self.$navigation_label,dismiss:self.$show_modal).environmentObject(self.core_data)
        }
    }
    
    func total_wear_time()->TimeInterval{
        var selected_date = Date()
        if !self.core_data.is_selected_date(date:Date()){
            selected_date = Calendar.current.startOfDay(for: self.core_data.selected_date)
            selected_date = selected_date.advanced(by: 86399)
        }
        let val = self.core_data.get_wear_timer_for_date(update_time: selected_date)
        return val
    }
}

