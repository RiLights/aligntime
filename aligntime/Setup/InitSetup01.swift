//
//  InitSetup_01.swift
//  aligntime
//
//  Created by Ostap on 14/05/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct InitSetup01: View {
    @EnvironmentObject var user_data: AlignTime
    
    var body: some View {
        VStack(alignment: .center){
            //Spacer()
            Image(systemName:"pano.fill")
                .font(.system(size: 70))
                .foregroundColor(.blue)
            Spacer()
            Divider()
            SetupParameterLink2(label:"How many aligners do you require?",value:String(Int(self.user_data.required_aligners_total)),destination:SliderSetup(label:"How many aligners do you require?",min:1,max:100,slider_value:self.$user_data.required_aligners_total))
            SetupParameterLink2(label:"Number of days for each aligners",value:String(Int(self.user_data.aligners_wear_days)),destination:SliderSetup(label:"Number of days for each aligners",min:1,max:31,slider_value:self.$user_data.aligners_wear_days))
            SetupParameterLink2(label:"Preferred aligners wear hours per day",value:String("\(self.user_data.wear_hours)h"),destination:SliderSetup(label:"Preferred aligners wear hours per day",min:12,max:24,slider_value:self.$user_data.wear_hours))
//            Group{
//                Text(NSLocalizedString("Aligner number you are wearing now",comment:""))
//                    .fixedSize(horizontal: false, vertical: true)
//                    .multilineTextAlignment(.center)
//                Text("\(Int(self.user_data.aligner_number_now))")
//                    .foregroundColor(.accentColor)
//            }
//            .font(.largeTitle)
//            Slider(value: self.$user_data.aligner_number_now, in: 1...100, step: 1)
            //Spacer()
//            Text(NSLocalizedString("Maybe Some explanation why do we need this setup and you can change it later, if want",comment:""))
//                .font(.headline)
//                .fontWeight(.ultraLight)
//                .multilineTextAlignment(.center)
            Spacer()
            WelcomeControllButton(next_button_label: "Next", destination:InitSetup02())
        }
        .padding(.horizontal, 30)
        .navigationBarTitle("")
    }
}

