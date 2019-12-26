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
                Text("Let's go through setting up your new treatment")
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                Text("(You would only need to do this once)")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 30)
                    .multilineTextAlignment(.center)
                Spacer()
                HStack(alignment: .center,spacing: 0){
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        ZStack(alignment: .center){
                            Rectangle()
                                .frame(height: 40)
                                .foregroundColor(Color.secondary)
                                .padding(0)
                                .opacity(0.5)
                            Text("Back")
                                .foregroundColor(Color.white)
                        }
                    }
                    NavigationLink(destination: DataCollect01()) {
                        ZStack(alignment: .center){
                            Rectangle()
                                .frame(height: 40)
                                .padding(0)
                            Text("Next")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal,20)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
