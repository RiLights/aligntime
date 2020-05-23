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
            InitSetup01Base()
            Spacer()
            WelcomeControllButton(next_button_label: "Next", destination:InitSetup02())
        }
        .padding(.horizontal, 30)
        .navigationBarTitle("")
    }
}

struct InitSetup01Base: View {
    @EnvironmentObject var user_data: AlignTime
    var body: some View {
        VStack(alignment: .center){
            SetupParameterLink(label:"How many aligners do you require?",value:String(Int(self.user_data.required_aligners_total)),destination:SliderSetup(label:"How many aligners do you require?",min:1,max:100,slider_value:self.$user_data.required_aligners_total))
            SetupParameterLink(label:"Number of days for each aligners",value:String(Int(self.user_data.aligners_wear_days)),destination:SliderSetup(label:"Number of days for each aligners",min:1,max:31,slider_value:self.$user_data.aligners_wear_days))
            SetupParameterLink(label:"Preferred aligners wear hours per day",value:String("\(self.user_data.wear_hours)h"),destination:SliderSetup(label:"Preferred aligners wear hours per day",min:12,max:24,slider_value:self.$user_data.wear_hours))
        }
    }
}

