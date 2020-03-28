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
        HStack {
            Text(NSLocalizedString("Today",comment:""))
                + Text(":")
                .font(.system(size: 23))
                .foregroundColor(Color.primary)
                .fontWeight(Font.Weight.light)
            Text("\(Date(), formatter: date_formatter)")
                .font(.system(size: 23))
                .foregroundColor(Color.accentColor)
                .fontWeight(Font.Weight.light)
        }
    }
}
