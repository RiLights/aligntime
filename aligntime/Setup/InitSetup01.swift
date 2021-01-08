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
//            ContentView2(min:1,max:100,slider_value:self.$user_data.required_aligners_total)
                //.padding(.top,30)
            //Divider()
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
//            SetupParameterLink(label:"How many aligners do you require?",value:String(Int(self.user_data.required_aligners_total)),destination:SliderSetup(label:"How many aligners do you require?",min:1,max:100,slider_value:self.$user_data.required_aligners_total))
            SetupParameterLink(label:"How many aligners do you require?",value:String(self.user_data.required_aligners_total),destination:PickerValue(label:"How many aligners do you require?",min:1,max:100,slider_value:self.$user_data.required_aligners_total))
            SetupParameterLink(label:"Number of days for each aligners",value:String(Int(self.user_data.aligners_wear_days)),destination:SliderSetup(label:"Number of days for each aligners",min:1,max:31,slider_value:self.$user_data.aligners_wear_days))
            SetupParameterLink(label:"Preferred aligners wear hours per day",value:String("\(Int(self.user_data.wear_hours))"),destination:SliderSetup(label:"Preferred aligners wear hours per day",min:12,max:24,slider_value:self.$user_data.wear_hours))
        }
    }
}

func string_array_rep(max_val:Int)->[String]{
    var val:[String] = []
    for i in 1...51{
        val.append(String(i))
    }
    return val
}

struct PickerValue: View {
    var label:String = "Undefined"
    var min:Int = 1
    var max:Int = 2
    @Binding var slider_value:Int

    var body: some View {
        VStack(alignment: .center){
            Group{
                Text(NSLocalizedString(label,comment:""))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("\(Int(slider_value))")
                    .foregroundColor(.blue)
            }
            .font(.headline)
            Picker(selection: self.$slider_value, label: Text("")) {
                ForEach((min...max), id: \.self) {
                    Text("\($0)")
                }
            }
            .labelsHidden()
            Spacer()
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 30)
        .navigationBarTitle("Additional Settings",displayMode: .inline)
    }
}


