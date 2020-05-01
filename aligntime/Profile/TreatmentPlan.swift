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
        VStack(alignment: .trailing, spacing: 0) {
            ScrollView(.vertical) {
                DataCollect01Body()
                    .padding(.top, 10)
                Toggle(isOn: $user_data.show_expected_aligner) {
                    Text(NSLocalizedString("Show expected aligner",comment:""))
                        .foregroundColor(.accentColor)
                        .font(.headline)
                }
                .padding(.horizontal, 40)
                .padding(.bottom,30)
                DataCollect02Body()
            }
        }
        .navigationBarTitle(Text(NSLocalizedString("Treatment Plan",comment:"")), displayMode: .inline)
    }
}

