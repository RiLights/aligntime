//
//  InitSetup02.swift
//  aligntime
//
//  Created by Ostap on 15/05/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct InitSetup02: View {
    @EnvironmentObject var user_data: AlignTime
    @State var sliderValue: Float = 1
    
    var body: some View {
        VStack(alignment: .center){
            //Spacer()
            Image(systemName:"rays")
                .font(.system(size: 70))
                .foregroundColor(.blue)
            Spacer()
            Group{
                Text(NSLocalizedString("Days you have been wearing current aligner",comment:""))
                Text("\(Int(sliderValue))")
            }
            .font(.largeTitle)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.blue)
            .multilineTextAlignment(.center)
            Slider(value: self.$sliderValue, in: 1...20, step: 1)
            Spacer()
            Text(NSLocalizedString("Maybe Some explanation why do we need this setup and you can change it later, if want",comment:""))
                .font(.headline)
                .fontWeight(.ultraLight)
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
            Spacer()
            WelcomeControllButton(next_button_label: "Next", destination:InitSetup03())
        }
        .padding(.horizontal, 30)
        .navigationBarTitle("")
    }
}
