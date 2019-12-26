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
                Text("Faster and more convenient to the user of Invisalign treatment. All information that is necessary, in relation to the treatment is in one app.")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 20)
                    .padding(20)
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
