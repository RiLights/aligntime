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
            Text(NSLocalizedString("This data is important for us to get maximum correct setup for you.",comment:""))
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
            WelcomeAdditionalSetup(label:"How many aligners do you require?",destination:SliderSetup(label:"How many aligners do you require?",min:1,max:100,slider_value:self.$user_data.required_aligners_total))
            WelcomeAdditionalSetup(label:"Number of days for each aligners",destination:SliderSetup(label:"Number of days for each aligners",min:1,max:31,slider_value:self.$user_data.aligners_wear_days))
            //WelcomeAdditionalSetup(label:"Preferred aligners wear hours per day",destination:SliderSetup())
            //WelcomeAdditionalSetup(label:"When did you start your treatment",destination:SliderSetup())
        }
    }
}

func WelcomeAdditionalSetup<Destination: View>(label: String, destination: Destination) -> some View {
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

struct SliderSetup: View {
    var label:String = "Undefined"
    var min:Float = 1
    var max:Float = 2
    @Binding var slider_value:Float
    
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
            Slider(value: self.$slider_value, in: min...max, step: 1)
            Spacer()
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 30)
        .navigationBarTitle("Additional Settings",displayMode: .inline)
    }
}
