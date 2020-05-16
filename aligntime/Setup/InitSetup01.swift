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
            Group{
                Text(NSLocalizedString("Aligner number you are wearing now",comment:""))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                Text("\(Int(self.user_data.aligner_number_now))")
                    .foregroundColor(.accentColor)
            }
            .font(.largeTitle)
            Slider(value: self.$user_data.aligner_number_now, in: 1...100, step: 1)
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

