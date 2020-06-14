//
//  InitSetup02.swift
//  aligntime
//
//  Created by Ostap on 15/05/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

func date_formatter_short() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}

struct InitSetup02: View {
    @EnvironmentObject var user_data: AlignTime
    
    let _date_formatter_short = date_formatter_short()
    
    var body: some View {
        VStack(alignment: .center){
            //Spacer()
            Image(systemName:"rays")
                .font(.system(size: 70))
                .foregroundColor(.blue)
            Spacer()
            Divider()
            InitSetup02Base()
            Spacer()
            WelcomeControllButton(next_button_label: "Ready", destination:Home())
        }
        .padding(.horizontal, 30)
        .navigationBarTitle("")
        .onAppear(){
            let max_date = get_max_start_date(days_wearing:self.user_data.days_wearing)
            if max_date<self.user_data.start_treatment{
                self.user_data.start_treatment = max_date
            }
        }
    }
}

struct InitSetup02Base: View {
    @EnvironmentObject var user_data: AlignTime
    var body: some View {
        VStack(alignment: .center){
            SetupParameterLink(label:"Aligner number you are wearing now",value:String(Int(self.user_data.aligner_number_now)),destination:PickerValue(label:"Aligner number you are wearing now",min:1,max:self.user_data.required_aligners_total,slider_value:self.$user_data.aligner_number_now))
            SetupParameterLink(label:"How many days have you been wearing current aligner for?",value:String(Int(self.user_data.days_wearing)),destination:SliderSetup(label:"How many days have you been wearing current aligner for?",min:1,max:self.user_data.aligners_wear_days,slider_value:self.$user_data.days_wearing))
            SetupParameterLink(label:"When did you start your treatment?",value:date_formatter_short().string(for: user_data.start_treatment)!,destination:StartTreatmentPicker())
        }
    }
}
