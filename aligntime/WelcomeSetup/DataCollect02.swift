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
    @State var reset_alert = false

    var body: some View {
        Section {
            VStack(alignment: .leading){
                VStack(alignment: .center){
                    Text(NSLocalizedString("Aligner number you are wearing now",comment:""))
                        .font(.headline)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
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
                else{
                    Button(action: {
                        self.reset_alert.toggle()
                        //self.user_data.intervals = [DayInterval(0, wear: true, time: Date())]
                        //self.user_data.update_min_max_dates()
                    }){
                        ZStack(alignment: .center){
                            Rectangle()
                               .frame(height: 35)
                               .foregroundColor(Color.blue)
                            Text(NSLocalizedString("Reset All History",comment:""))
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding(.bottom,5)
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(view_mode)
        .navigationBarHidden(view_mode)
        .alert(isPresented: self.$reset_alert) {
            Alert(title: Text(NSLocalizedString("Reset All History",comment:"")), message: Text(NSLocalizedString("Do you want to erase all history?",comment:"")), primaryButton: .destructive(Text(NSLocalizedString("Erase",comment:""))) {
                self.user_data.intervals = [DayInterval(0, wear: true, time: Date())]
                self.user_data.current_state = true
                self.user_data.update_min_max_dates()
                },secondaryButton: .cancel())
        }
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
