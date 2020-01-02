//
//  DataCollect02.swift
//  aligntime
//
//  Created by Ostap on 26/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct DataCollect02: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var user_data: AlignTime
    @State private var ready_setup = false

    var body: some View {
        Section {
            VStack(alignment: .center){
                VStack(alignment: .center){
                    Text("Aligner number you are wearing now")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("\(user_data.align_count_now)")
                        Stepper("", value: $user_data.align_count_now, in: 1...200)
                    }
                    .padding(.horizontal, 30)
                    Divider()
                }
                .padding(.bottom,40)
                VStack(alignment: .center){
                    Text("How many days have you been wearing current aligner for?")
                        .font(.headline)
                        .padding(.horizontal, 20)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("\(user_data.days_wearing)")
                        Stepper("", value: $user_data.days_wearing, in: 1...31)
                    }
                    .padding(.horizontal, 30)
                    Divider()
                }
                .padding(.bottom,40)
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
                            Text("Back")
                                .foregroundColor(Color.white)
                        }
                    }
                    NavigationLink(destination: Home()) {
                        ZStack(alignment: .center){
                            Rectangle()
                                .frame(height: 40)
                                .padding(0)
                            Text("Ready")
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
