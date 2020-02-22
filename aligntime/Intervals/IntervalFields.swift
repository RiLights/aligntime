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
            Text("Total Wear Time For Today: 10:11")
                .foregroundColor(.accentColor)
                .font(.system(size: 18))
                .padding(.bottom, 5)
        }
        .sheet(isPresented: self.$show_modal) {
                IntervalEditList(navigation_label: self.$navigation_label).environmentObject(self.core_data)
            
        }
    }
}

