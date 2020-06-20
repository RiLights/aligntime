//
//  TodayHeader.swift
//  aligntime
//
//  Created by Ostap on 12/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct TodayHeader: View {
    @EnvironmentObject var core_data: AlignTime
    
    var date_formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var body: some View {
        VStack{
            if core_data.show_current_date{
                HStack {
                    Text(NSLocalizedString("Today",comment:""))
                        .fontWeight(Font.Weight.light)
                        + Text(":")
                        .foregroundColor(Color.primary)
                    Text("\(Date(), formatter: date_formatter)")
                        .foregroundColor(Color.accentColor)
                        .fontWeight(Font.Weight.light)
                }
                .padding(.bottom,10)
            }
            HStack (spacing:0){
                Text(NSLocalizedString("Expected Aligner",comment:""))
                    .foregroundColor(Color.primary)
                    .fontWeight(Font.Weight.light)
                    .multilineTextAlignment(.center)
                Text(" #:")
                Text(" \(Int(self.core_data.aligner_number_now))")
                    .foregroundColor(Color.accentColor)
            }
//                + Text("""
//                    \(Int(self.core_data.aligner_number_now))
//                    """)
                    //.foregroundColor(Color.accentColor)
            AlignerNumberVisualisation()
        }

        //.font(.title)
        //.scaledFont(size: 25)
        //.font(.title)//.system(size: 23)
        //.scaledFont(size: -20)
    }
}

struct AlignerNumberVisualisation: View {
    @EnvironmentObject var core_data: AlignTime

    var date_formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    

    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 2)
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 4)
                HStack(spacing:0) {
                    ForEach(1...Int(self.core_data.days_wearing), id: \.self) { width_id in
                        HStack(spacing:0) {
                            Rectangle()
                            .frame(width:2)
                            .foregroundColor(.accentColor)
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(.accentColor)
                                .frame(width: CGFloat(200/self.core_data.get_days_for_current_aligner()), height: 4)
                        }
                    }
                    Spacer()
                }
            }
            .frame(width: 200, height: 8)
            if (self.core_data.show_aligner_description && self.core_data.days_left != "0"){
                if self.core_data.days_left_on_aligner == 0{
                    Group{
                        Text(NSLocalizedString("Last day for aligner",comment:""))
                            + Text(" #:")
                            + Text(" \(Int(self.core_data.aligner_number_now)+1)")
                                .foregroundColor(.accentColor)
                    }
                    .font(.caption)
                }
                else{
                    HStack(spacing:4){
                        Text("\(self.core_data.days_left_on_aligner)")
                            .foregroundColor(.accentColor)
                        Group{
                            if self.core_data.days_left_on_aligner == 1 {
                                Text(NSLocalizedString("day",comment:""))
                            }
                            else if self.core_data.days_left_on_aligner<=4{
                                Text(NSLocalizedString("days/4",comment:""))
                            }
                            else{
                                Text(NSLocalizedString("days",comment:""))
                            }
                        }
                        Text(NSLocalizedString("left for the current aligner",comment:""))
                    }
                    .font(.callout)
                }
            }
        }
    }
}
