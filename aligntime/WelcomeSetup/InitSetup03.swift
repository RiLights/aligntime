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
            Group{
                Text(NSLocalizedString("Additional Settings",comment:""))
            }
            .font(.largeTitle)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.blue)
            .multilineTextAlignment(.center)
            Text(NSLocalizedString("This data is important for us to get maximum correct setup for you.",comment:""))
                .font(.headline)
                .fontWeight(.ultraLight)
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
            AdditionalSettings()
            Spacer()
            WelcomeControllButton(next_button_label: "Ready", destination:Home())
        }
        .padding(.horizontal, 30)
        .navigationBarTitle("")
    }
}

struct AdditionalSettings: View {
    var body: some View {
        VStack(alignment: .center){
            Divider()
            WelcomeAdditionalSetup(label:"How many aligners do you require",destination:AlignerYouReq())
            WelcomeAdditionalSetup(label:"Number of days for each aligners",destination:AlignerYouReq())
            WelcomeAdditionalSetup(label:"Preferred aligners wear hours per day",destination:AlignerYouReq())
            WelcomeAdditionalSetup(label:"When did you start your treatment",destination:AlignerYouReq())
        }
    }
}

func WelcomeAdditionalSetup<Destination: View>(label: String, destination: Destination) -> some View {
    return NavigationLink(destination: destination) {
        VStack(alignment: .center,spacing: 15){
            HStack(alignment: .center,spacing: 0) {
                Text(label)
                    //.padding(.leading,3)
                Spacer()
                Image(systemName: "chevron.right")
            }
            Divider()
        }
        .padding(.top,5)
    }
}

struct AlignerYouReq: View {
    @State var sliderValue: Float = 75
    
    var body: some View {
        VStack(alignment: .center){
            Text(NSLocalizedString("How many aligners do you require \n \(Int(sliderValue))",comment:""))
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
            Slider(value: self.$sliderValue, in: 1...100, step: 1)
            Spacer()
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 30)
        .navigationBarTitle("Additional Settings",displayMode: .inline)
    }
}
