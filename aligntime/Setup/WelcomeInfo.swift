//
//  Welcome.swift
//  aligntime
//
//  Created by Ostap on 25/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct WelcomeInfo: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        Section {
            VStack(alignment: .center){
                Image(systemName:"square.stack.3d.down.right.fill")
                    .font(.system(size: 70))
                    .foregroundColor(.blue)
                Text(NSLocalizedString("setting_up",comment:""))
                    .font(.largeTitle)
                    //.fontWeight(.bold)
                    //.foregroundColor(.blue)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                    .multilineTextAlignment(.center)
                Text(NSLocalizedString("to_do_this_once",comment:""))
                    .font(.headline)
                    .fontWeight(.ultraLight)
                    //.foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                Spacer()
                WelcomeControllButton(next_button_label: "Next", destination:InitSetup01())
            }
            .padding(.horizontal, 30)
            .navigationBarTitle("")
        }
    }
}
