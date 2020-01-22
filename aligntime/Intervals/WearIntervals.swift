//
//  WearIntervals.swift
//  aligntime
//
//  Created by Ostap on 21/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct WearIntervals: View {
    @EnvironmentObject var core_data: AlignTime
    @Binding var navigation_label:String
    @Binding var show_modal:Bool
    //@Binding var intrevals:[DayInterval]
    
    func intervals_color_day(date:Date)->Color{
        if !self.core_data.is_selected_date(date:date){
            return Color.secondary
        }
        return Color.accentColor
    }
    
    
    var body: some View {
        Button(action: {
            self.navigation_label = "Wear Times"
            //self.intrevals = self.core_data.get_wear_day_list()
            self.show_modal.toggle()
        }) {
            VStack{
                Text("Wear Times:")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 21))
                ForEach(core_data.get_wear_day_list()) { i in
                    HStack{
                        Text("\(i.time_string )")
                            .font(.system(size: 18))
                            .fontWeight(.light)
                            .foregroundColor(self.intervals_color_day(date:i.time))
                            .frame(width: 50)
                        Text("-")
                            .foregroundColor(.accentColor)
                            .font(.system(size: 21))
                        if (self.core_data.intervals.count<=i.id+1){
                            Text("Now")
                                .font(.system(size: 18))
                                .fontWeight(.light)
                                .foregroundColor(.accentColor)
                                .frame(width: 50)
                        }
                        else{
                            Text("\(self.core_data.intervals[i.id+1].time_string)")
                                .font(.system(size: 18))
                                .fontWeight(.light)
                                .frame(width: 50)
                                .foregroundColor(self.intervals_color_day(date:self.core_data.intervals[i.id+1].time))
                        }
                    }
                }
            }
        }
    }
}


