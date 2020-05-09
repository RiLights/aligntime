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
                        
            }
        }
        //.font(.title)
        //.scaledFont(size: 25)
        //.font(.title)//.system(size: 23)
        //.scaledFont(size: -20)
    }
}
