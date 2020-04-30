//
//  Calendar.swift
//  aligntime
//
//  Created by Ostap on 23/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI


struct CalendarManager: View {
    @EnvironmentObject var core_data: AlignTime
    var isAnimation:Bool = true
   
    var body: some View {
        VStack(alignment: .center) {
            RKViewController()
            AlignerNoticion()
            IntervalFields()
                //.padding(.top, 20)
                .padding(.horizontal, 30)
                .animation(.spring())
            Spacer()
        }.onAppear(perform: startUp)
    }
       
    func startUp() {
            self.core_data.selected_date = Date()
            core_data.update_min_max_dates()
            // example of some foreground colors
            core_data.colors.weekdayHeaderColor = Color.white
            core_data.colors.monthHeaderColor = Color.green
            core_data.colors.textColor = Color.blue
            core_data.colors.disabledColor = Color.red

        self.core_data.selected_month = Calendar.current.dateComponents(in: .autoupdatingCurrent, from: Date()).month ?? 0
       }
}

struct AlignerNoticion: View {
    @EnvironmentObject var core_data: AlignTime


    var body: some View {
        HStack(){
            if self.core_data.is_last_day_for_aligner(date: self.core_data.selected_date){
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 5, height: 5)
                    .padding(.leading,10)
                Text("Last day for aligner")
                    .font(.footnote)
            }
            Spacer()
        }
        .foregroundColor(.accentColor)
    }
}

