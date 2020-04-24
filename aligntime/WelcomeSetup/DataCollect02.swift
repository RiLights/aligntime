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
    var min_aligner_date:Date {
        get {
            return Calendar.current.date(byAdding: .day, value: -(self.user_data.aligners_wear_days), to: Date())!
        }
    }
    let min_date = Calendar.current.date(byAdding: .year, value: -5, to: Date())

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
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
                .padding(.top,15)
                .padding(.bottom,40)
                
                VStack(alignment: .center){
                    Text(NSLocalizedString("How many days have you been wearing current aligner for?",comment:""))
                        .font(.headline)
                        .padding(.horizontal, 30)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("\(user_data.days_wearing)")
                        Stepper("", value: $user_data.days_wearing, in: 0...user_data.aligners_wear_days)
                    }
                    .padding(.horizontal, 30)
                    Divider()
                }
                .padding(.bottom,40)
                
                if self.view_mode == false {
                    Toggle(isOn: $user_data.show_expected_aligner) {
                        Text(NSLocalizedString("Show expected aligner",comment:""))
                            .foregroundColor(.accentColor)
                            .font(.headline)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom,40)
                }
                
                VStack(alignment: .center){
                    Text(NSLocalizedString("When did you start your treatment?",comment:""))
                        .font(.headline)
                        //.fontWeight(.regular)
                        .foregroundColor(.blue)
                        //.padding(.horizontal, 30)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                    DatePicker(selection: $user_data.start_treatment, in: min_date!...Date(), displayedComponents: .date) {
                            Text("")
                        }
                        .labelsHidden()
                    HStack{
                        Text(NSLocalizedString("Start date is:",comment:""))
                        Text("\(user_data.start_treatment, formatter: dateFormatter)")
                    }
                    .font(.footnote)
                    .foregroundColor(.blue)
                }
                .padding(.horizontal, 40)
                
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
