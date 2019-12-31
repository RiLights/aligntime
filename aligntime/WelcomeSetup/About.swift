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
    
    var body: some View {
        Section {
            VStack(alignment: .center){
                Text("AlignTime is a Mobile app, created by users to assist other users in keeping track of Invisalign braces wear time. \n\n AlignTime helps record your daily wear time for each tray, sends reminders if an aligner has been left out for too long and alerts you when its time to change your tray. You can monitor progress for each aligner wear time using Calendar functionality.")
                    .font(.system(size: 21))
                    .fontWeight(.regular)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 12)
                    .padding(12)
                    .multilineTextAlignment(.center)
                Spacer()
                HStack(alignment: .firstTextBaseline,spacing: 0){
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        ZStack(alignment: .center){
                            Rectangle()
                                .frame(height: 40)
                                .foregroundColor(Color.secondary)
                                .opacity(0.5)
                            Text("Back")
                                .foregroundColor(Color.white)
                        }
                    }
                }
                .padding(.horizontal,20)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
