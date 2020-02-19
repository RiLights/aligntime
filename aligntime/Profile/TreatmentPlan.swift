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
            DataCollect01(view_mode: false)
//            List {
//                Text("How many aligners do you require:  \(user_data.required_aligners_total)")
//                Text("Number of days for each aligners:  \(user_data.aligners_wear_days)")
//                Text("Start your treatment:  \(user_data.start_treatment,formatter: date_formatter)")
//                Text("Aligner number you are wearing:  \(user_data.aligner_number_now)")
//                Text("Days wearing current aligner:  \(user_data.current_aligner_days)")
//                Text("Complete (Debug):  \(String(user_data.complete))")
//            }
//            Button(action: {
//                self.user_data.resetDefaults()
//                self.user_data.complete = false
//                //self.user_data.push_user_defaults()
//            }){
//                ZStack(alignment: .center){
//                    Rectangle()
//                        .frame(height: 40)
//                        .foregroundColor(Color.blue)
//                    Text("Reset To Defaults")
//                        .foregroundColor(Color.white)
//                }
//            }
        }
        .navigationBarTitle(Text("Treatment Plan"), displayMode: .large)
    }
}

