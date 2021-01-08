//
//  WelcomeControllButton.swift
//  aligntime
//
//  Created by Ostap on 15/05/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI


func WelcomeControllButton<Destination: View>(next_button_label: String, destination: Destination) -> some View {
//    if next_button_label == "Ready"{
//        if 
//    }
    return NavigationLink(destination: destination) {
        HStack(alignment: .center,spacing: 0) {
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: 7)
                    .frame(height: 40)
                    .padding(0)
                Text(NSLocalizedString(next_button_label,comment:""))
                    .foregroundColor(.white)
            }
        }
        .padding(.bottom,10)
    }
}
