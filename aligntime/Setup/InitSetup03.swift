//
//  InitSetup03.swift
//  aligntime
//
//  Created by Ostap on 15/05/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct InitSetup03: View {
    @EnvironmentObject var user_data: AlignTime
    
    var body: some View {
        VStack(alignment: .center){
            //Spacer()
            Image(systemName:"line.horizontal.3.decrease.circle")
                .font(.system(size: 70))
                .foregroundColor(.blue)
            Spacer()
            Text(NSLocalizedString("Additional Settings",comment:""))
                .font(.largeTitle)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding(.vertical,10)
            Text(NSLocalizedString("data is important for us",comment:""))
                .font(.headline)
                .fontWeight(.ultraLight)
                .multilineTextAlignment(.center)
                .padding(.bottom,10)
            AdditionalSettings()
            Spacer()
            WelcomeControllButton(next_button_label: "Ready", destination:Home())
        }
        .padding(.horizontal, 30)
        .navigationBarTitle("")
    }
}

struct AdditionalSettings: View {
    @EnvironmentObject var user_data: AlignTime
    
    var body: some View {
        VStack(alignment: .center){
            Divider()
            SetupParameterLink(label:"How many aligners do you require?",destination:SliderSetup(label:"How many aligners do you require?",min:1,max:100,slider_value:self.$user_data.required_aligners_total))
            SetupParameterLink(label:"Number of days for each aligners",destination:SliderSetup(label:"Number of days for each aligners",min:1,max:31,slider_value:self.$user_data.aligners_wear_days)) // need to add infor that you change days per aligner later in settings
            SetupParameterLink(label:"When did you start your treatment",destination:StartTreatmentPicker())
            SetupParameterLink(label:"Preferred aligners wear hours per day",destination:SliderSetup(label:"Preferred aligners wear hours per day",min:12,max:24,slider_value:self.$user_data.wear_hours))
        }
    }
}

func SetupParameterLink<Destination: View>(label: String, destination: Destination) -> some View {
    return NavigationLink(destination: destination) {
        VStack(alignment: .center,spacing: 15){
            HStack(alignment: .center,spacing: 0) {
                Text(NSLocalizedString(label,comment:""))
                    .foregroundColor(.primary)
                    //.padding(.leading,3)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            Divider()
        }
        .padding(.top,5)
    }
}

struct StartTreatmentPicker: View {
    @EnvironmentObject var user_data: AlignTime
    let min_date = Calendar.current.date(byAdding: .year, value: -5, to: Date())
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
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
                Text("\(user_data.start_treatment, formatter: dateFormatter)")
            }
            .font(.footnote)
            .foregroundColor(.blue)
        }
    }
}
