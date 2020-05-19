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
    //let t = "\(Date(),formatter: date_formatter_long())"
    //"\(self.user_data.start_treatment)"
    
    var body: some View {
        VStack(alignment: .center){
            //Spacer()
            Image(systemName:"rays")
                .font(.system(size: 70))
                .foregroundColor(.blue)
            Spacer()
            Divider()
            SetupParameterLink2(label:"Aligner number you are wearing now",value:String(Int(self.user_data.aligner_number_now)),destination:SliderSetup(label:"Aligner number you are wearing now",min:1,max:100,slider_value:self.$user_data.aligner_number_now))
            SetupParameterLink2(label:"How many days have you been wearing current aligner for?",value:String(Int(self.user_data.days_wearing)),destination:SliderSetup(label:"How many days have you been wearing current aligner for?",min:1,max:20,slider_value:self.$user_data.days_wearing))
            SetupParameterLink2(label:"When did you start your treatment?",value:date_formatter_short().string(for: self.user_data.start_treatment)!,destination:StartTreatmentPicker())
//            Group{
//                Text(NSLocalizedString("How many days have you been wearing current aligner for?",comment:""))
//                Text("\(Int(self.user_data.days_wearing))")
//                    .foregroundColor(.blue)
//            }
//            .font(.largeTitle)
//            .fixedSize(horizontal: false, vertical: true)
//            .multilineTextAlignment(.center)
//            Slider(value: self.$user_data.days_wearing, in: 1...20, step: 1)
//            Spacer()
//            Text(NSLocalizedString("Maybe Some explanation why do we need this setup and you can change it later, if want",comment:""))
//                .font(.headline)
//                .fontWeight(.ultraLight)
//                .multilineTextAlignment(.center)
            Spacer()
            WelcomeControllButton(next_button_label: "Ready", destination:Home())
        }
        .padding(.horizontal, 30)
        .navigationBarTitle("")
    }
}
