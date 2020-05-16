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
    
    var body: some View {
        VStack(alignment: .center){
            //Spacer()
            Image(systemName:"rays")
                .font(.system(size: 70))
                .foregroundColor(.blue)
            Spacer()
            Group{
                Text(NSLocalizedString("How many days have you been wearing current aligner for?",comment:""))
                Text("\(Int(self.user_data.days_wearing))")
                    .foregroundColor(.blue)
            }
            .font(.largeTitle)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
            Slider(value: self.$user_data.days_wearing, in: 1...20, step: 1)
//            Spacer()
//            Text(NSLocalizedString("Maybe Some explanation why do we need this setup and you can change it later, if want",comment:""))
//                .font(.headline)
//                .fontWeight(.ultraLight)
//                .multilineTextAlignment(.center)
            Spacer()
            WelcomeControllButton(next_button_label: "Next", destination:InitSetup03())
        }
        .padding(.horizontal, 30)
        .navigationBarTitle("")
    }
}
