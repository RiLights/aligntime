//
//  OffEvents.swift
//  aligntime
//
//  Created by Ostap on 22/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct OffEvents: View {
    @EnvironmentObject var core_data: AlignTime
    @Binding var navigation_label:String
    @Binding var show_modal:Bool
    
    func intervals_color_day(date:Date)->Color{
        if !self.core_data.is_selected_date(date:date){
            return Color.secondary
        }
        return Color.accentColor
    }
    
    
    var body: some View {
        Button(action: {
            self.navigation_label = "Wear Times"
            self.show_modal.toggle()
        }) {
            VStack{
                Text("Wear Times:")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 21))
                    .frame(width: 120)
                ForEach(core_data.get_wear_days()) { i in
                    HStack{
                        Text("\(i.time_string )")
                            .font(.system(size: 18))
                            .fontWeight(.light)
                            .foregroundColor(self.intervals_color_day(date:i.time))
                            .frame(width: 50)
                    }
                }
            }
        }
    }
}


