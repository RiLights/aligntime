//
//  DataCollect01.swift
//  aligntime
//
//  Created by Ostap on 26/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct DataCollect01: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @EnvironmentObject var user_data: UserData
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    let min_date = Calendar.current.date(byAdding: .year, value: -3, to: Date())

    var body: some View {
        Section() {
            VStack(alignment: .center){
                VStack(alignment: .center){
                    Text("How many aligners do you require for your treatment?")
                        .font(.headline)
                        //.fontWeight(.regular)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                    HStack {
                        TextField("",value:$user_data.require_count,formatter: NumberFormatter())
                            //.keyboardType(.numberPad) Make event to hide keyboar when numer is more then ...
                        Stepper("", value: $user_data.require_count, in: 1...200)
                    }
                    .padding(.horizontal, 20)
                    Divider()
                }
                .padding(.bottom,40)
                VStack(alignment: .center){
                    Text("Number of days for each aligners")
                        .font(.headline)
                        //.fontWeight(.regular)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("\(user_data.aligners_count)")
                        Stepper("", value: $user_data.aligners_count, in: 1...31)
                    }
                    .padding(.horizontal, 20)
                    Divider()
                }
                .padding(.bottom,40)
                VStack(alignment: .center){
                    Text("When did you start your treatment?")
                        .font(.headline)
                        //.fontWeight(.regular)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 30)
                        .multilineTextAlignment(.center)
                    DatePicker(selection: $user_data.start_treatment, in: min_date!...Date(), displayedComponents: .date) {
                        Text("")
                        }
                    Text("Start date is: \(user_data.start_treatment, formatter: dateFormatter)")
                        .font(.footnote)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 30)
                }

                Spacer()
                HStack(alignment: .center,spacing: 0){
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
                    NavigationLink(destination: DataCollect02()) {
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
