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
            HStack {
                Text(NSLocalizedString("Today",comment:""))
                    .fontWeight(Font.Weight.light)
                    + Text(":")
                    .foregroundColor(Color.primary)
                Text("\(Date(), formatter: date_formatter)")
                    .foregroundColor(Color.accentColor)
                    .fontWeight(Font.Weight.light)
            }
            if core_data.show_expected_aligner{
                Text(NSLocalizedString("Expected Aligner #: ",comment:""))
                    .foregroundColor(Color.primary)
                    .fontWeight(Font.Weight.light)
                    + Text("""
                        \(self.core_data.aligner_number_now)
                        """)
                        .foregroundColor(Color.accentColor)
            AlignerNumberVisualisation()
            }
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
                    ForEach(0...self.core_data.days_wearing-1, id: \.self) { width in
                        HStack(spacing:0) {
                            Rectangle()
                            .frame(width:2)
                            .foregroundColor(.accentColor)
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(.accentColor)
                                .frame(width: CGFloat(200/self.core_data.aligners[self.core_data.aligner_number_now].days), height: 4)
                        }
                    }
                    Spacer()
                }
            }
            .frame(width: 200, height: 8)
        }
    }
}
