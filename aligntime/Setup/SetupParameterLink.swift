//
//  SwiftUIView.swift
//  aligntime
//
//  Created by Ostap on 21/05/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI


func SetupParameterLink<Destination: View>(label: String,value:String, destination: Destination) -> some View {
    return NavigationLink(destination: destination) {
        VStack(alignment: .center,spacing: 15){
            HStack(alignment: .center,spacing: 0) {
                Text(NSLocalizedString(label,comment:""))
                    .foregroundColor(.primary)
                Spacer()
                Text(value)
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .padding(.leading,5)
            }
            Divider()
        }
        .padding(.top,5)
    }
}

struct StartTreatmentPicker: View {
    @EnvironmentObject var user_data: AlignTime
    let min_date = Calendar.current.date(byAdding: .year, value: -5, to: Date())
    
    var body: some View {
        VStack(alignment: .center){
            Text(NSLocalizedString("When did you start your treatment?",comment:""))
                .font(.headline)
                .foregroundColor(.blue)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
            DatePicker(selection: $user_data.start_treatment, in: min_date!...Calendar.current.date(byAdding: .day, value: Int(-(user_data.days_wearing)), to: Date())!, displayedComponents: .date) {
                    Text("")
                }
                .labelsHidden()
            HStack{
                Text(NSLocalizedString("Start date is:",comment:""))
                Text("\(user_data.start_treatment, formatter: date_formatter_long())")
            }
            .font(.footnote)
            .foregroundColor(.blue)
        }
    }
}
