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
    @State var view_mode:Bool = true

    var body: some View {
        Section {
            VStack(alignment: .leading){
                VStack(alignment: .center){
                    Text(NSLocalizedString("Aligner number you are wearing now",comment:""))
                        .font(.headline)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 30)
                    HStack {
                        Text("\(user_data.aligner_number_now)")
                        Stepper("", value: $user_data.aligner_number_now, in: 1...200)
                    }
                    .padding(.horizontal, 30)
                    Divider()
                }
                .padding(.top,85)
                .padding(.bottom,40)
                VStack(alignment: .center){
                    Text(NSLocalizedString("How many days have you been wearing current aligner for?",comment:""))
                        .font(.headline)
                        .padding(.horizontal, 30)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("\(user_data.current_aligner_days)")
                        Stepper("", value: $user_data.current_aligner_days, in: 1...31)
                    }
                    .padding(.horizontal, 30)
                    Divider()
                }
                .padding(.bottom,40)
                VStack(alignment: .center){
                    Text(NSLocalizedString("Preferred aligners wear hours per day",comment:""))
                        .font(.headline)
                        .padding(.horizontal, 30)
                        .foregroundColor(.blue)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("\(user_data.wear_hours)")
                        Stepper("", value: $user_data.wear_hours, in: 12...24)
                    }
                    .padding(.horizontal, 30)
                    Divider()
                }
                .padding(.bottom,40)
                Spacer()
                if self.view_mode{
                    DataCollectControllButton02()
                        .padding(.horizontal,20)
                        .padding(.bottom,5)
                }
            }
        }
        .navigationBarTitle(view_mode ? "" : NSLocalizedString("Treatment Plan",comment:""))
        .navigationBarBackButtonHidden(view_mode)
        .navigationBarHidden(view_mode)
    }
}

struct DataCollectControllButton02: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var user_data: AlignTime

    var body: some View {
        HStack(alignment: .center,spacing: 0){
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
            NavigationLink(destination: Home()) {
                ZStack(alignment: .center){
                    Rectangle()
                        .frame(height: 40)
                        .padding(0)
                    Text(NSLocalizedString("Ready",comment:""))
                        .foregroundColor(.white)
                }
            }
        }
    }
}
