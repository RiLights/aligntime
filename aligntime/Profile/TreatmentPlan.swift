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
                VStack(alignment: .center){
                     Text(NSLocalizedString("Changer aligner time notification",comment:""))
                         .font(.headline)
                         .foregroundColor(.blue)
                         .fixedSize(horizontal: false, vertical: true)
                         .multilineTextAlignment(.center)
                     DatePicker(selection: $user_data.aligner_time_notification, displayedComponents: .hourAndMinute) {
                             Text("")
                         }
                         .labelsHidden()
                 }
                 .padding(.horizontal, 40)
                Toggle(isOn: $user_data.show_expected_aligner) {
                    Text(NSLocalizedString("Show expected aligner",comment:""))
                        .foregroundColor(.accentColor)
                        .font(.headline)
                }
                .padding(.horizontal, 40)
                .padding(.bottom,30)
                DataCollect02Body()
                //.padding(.bottom,30)
            }
        }
        .navigationBarTitle(Text(NSLocalizedString("Treatment Plan",comment:"")), displayMode: .inline)
    }
}

