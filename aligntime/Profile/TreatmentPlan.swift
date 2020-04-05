//
//  TreatmentPlan.swift
//  aligntime
//
//  Created by Ostap on 18/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//
import SwiftUI

struct TreatmentPlan: View {
    @EnvironmentObject var user_data: AlignTime
    
    var date_formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 18) {
            ScrollView(.vertical) {
                Text("")
                DataCollect01(view_mode: false)
                DataCollect02(view_mode: false)
            }
        }
        .navigationBarTitle(Text(NSLocalizedString("Treatment Plan",comment:"")), displayMode: .large)
    }
}

