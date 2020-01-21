//
//  OffIntervals.swift
//  aligntime
//
//  Created by Ostap on 21/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct OffIntervals: View {
    @EnvironmentObject var core_data: AlignTime
    @Binding var navigation_label:String
    @Binding var show_modal:Bool
    
    
    var body: some View {
        Button(action: {
            self.navigation_label = "Off Times"
            self.show_modal.toggle()
        }) {
            VStack{
                Text("Off Times:")
                    .foregroundColor(.red)
                    .font(.system(size: 21))
                ForEach(core_data.get_off_day_list()) { i in
                    HStack{
                        if self.core_data.is_selected_date(date:i.time)
                        {
                            Text("\(i.time_string)")
                                .font(.system(size: 18))
                                .fontWeight(.light)
                                .foregroundColor(.red)
                                .frame(width: 50)
                        }
                        else{
                            Text("\(i.time_string)")
                                .font(.system(size: 18))
                                .fontWeight(.light)
                                .foregroundColor(.secondary)
                                .frame(width: 50)
                        }
                        Text("-")
                            .foregroundColor(.red)
                            .font(.system(size: 21))
                        Text("\(self.core_data.intervals[i.id+1].time_string )")
                            .font(.system(size: 18))
                            .fontWeight(.light)
                            .foregroundColor(.red)
                            .frame(width: 50)
                    }
                }
            }
        }
    }
}

