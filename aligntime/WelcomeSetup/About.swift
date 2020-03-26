//
//  About.swift
//  aligntime
//
//  Created by Ostap on 26/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct About: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var view_mode:Bool = true
    
    var body: some View {
        Section {
            VStack(alignment: .center){
                Image("iter02_2_welcome_small")
                Text(NSLocalizedString("About_AlignTime",comment:""))
                    .font(.system(size: 17))
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 12)
                    .padding(12)
                    .multilineTextAlignment(.center)
                Spacer()
                if self.view_mode{
                    AboutControllButton()
                        .padding(.horizontal,20)
                }
            }
            .navigationBarBackButtonHidden(view_mode)
        }
    }
}

struct AboutControllButton: View {
@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        HStack(alignment: .firstTextBaseline,spacing: 0){
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                ZStack(alignment: .center){
                    Rectangle()
                        .frame(height: 40)
                        .foregroundColor(Color.secondary)
                        .opacity(0.5)
                    Text(NSLocalizedString("Back",comment:""))
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}
