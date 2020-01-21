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
    @Binding var intervals:[DayInterval]
    @Binding var navigation_label:String
    @Binding var show_modal:Bool
    
    
    var body: some View {
        Button(action: {
            self.navigation_label = "Wear Times"
            self.show_modal.toggle()
        }) {
            VStack{
                Text("Wear Times:")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 21))
                ForEach(core_data.get_wear_day_list()) { i in
                    HStack{
                        if self.core_data.is_selected_date(date:i.time)
                        {
                            Text("\(i.time_string )")
                                .font(.system(size: 18))
                                .fontWeight(.light)
                                .foregroundColor(.accentColor)
                                .frame(width: 50)
                        }
                        else{
                            Text("\(i.time_string )")
                                .font(.system(size: 18))
                                .fontWeight(.light)
                                .foregroundColor(.secondary)
                        }
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
                                .foregroundColor(.accentColor)
                                .frame(width: 50)
                        }
                    }
                }
            }
        }
    }
}


