//
//  DataCollect01.swift
//  aligntime
//
//  Created by Ostap on 26/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI
import UIKit

struct CustomTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: Int
        var didBecomeFirstResponder = false

        init(text: Binding<Int>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = Int(textField.text!) ?? 0
        }
    }

    @Binding var text: Int
    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = String(text)
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct DataCollect01: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var user_data: AlignTime
    @State var view_mode:Bool = true
    
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
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                    HStack {
                        CustomTextField(text: $user_data.required_aligners_total, isFirstResponder: false)
                            .keyboardType(.numberPad)
                        HStack (spacing: 0) {
                            Button(action: { self.user_data.required_aligners_total -= 1})
                            {
                                HStack {
                                    Image(systemName: "minus")
                                }.padding(0)
                                .onTapGesture {
                                       UIApplication.shared.endEditing()
                                }
                                .frame(minWidth: 0, maxWidth: 50,  minHeight: 30)
                                .background(Color.secondary.opacity(0.2))
                                .foregroundColor(.secondary)
                                .cornerRadius(5)
                            }
                            Divider()
                                .background(Color.secondary.opacity(0.3))
                                .frame(maxHeight: 20)
                            Button(action: { self.user_data.required_aligners_total += 1})
                            {
                                HStack {
                                    Image(systemName: "plus")
                                }.padding(0)
                                .frame(minWidth: 0, maxWidth: 50, minHeight: 30)
                                .background(Color.secondary.opacity(0.2))
                                .foregroundColor(.secondary)
                                .cornerRadius(5)
                            }
                        }
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
                        CustomTextField(text: $user_data.aligners_wear_days, isFirstResponder: false)
                            .keyboardType(.asciiCapableNumberPad)
                        HStack (spacing: 0) {
                            Button(action: { self.user_data.aligners_wear_days -= 1})
                            {
                                HStack {
                                    Image(systemName: "minus")
                                }
                                .frame(minWidth: 0, maxWidth: 50,  minHeight: 30)
                                .background(Color.secondary.opacity(0.2))
                                .foregroundColor(.secondary)
                                .cornerRadius(5)
                            }
                            Divider()
                            .background(Color.secondary.opacity(0.3))
                            .frame(maxHeight: 20)
                            Button(action: { self.user_data.aligners_wear_days += 1})
                            {
                                HStack {
                                    Image(systemName: "plus")
                                }
                                .frame(minWidth: 0, maxWidth: 50, minHeight: 30)
                                .background(Color.secondary.opacity(0.2))
                                .foregroundColor(.secondary)
                                .cornerRadius(5)
                            }
                        }
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
                        .labelsHidden()
                    Text("Start date is: \(user_data.start_treatment, formatter: dateFormatter)")
                        .font(.footnote)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 30)
                }
                
                Spacer()
                if self.view_mode{
                    DataCollectControllButton01()
                        .padding(.horizontal,20)
                }
                
            }
            .onTapGesture {
                   UIApplication.shared.endEditing()
            }
        }
        .navigationBarBackButtonHidden(view_mode)
    }
}

struct DataCollectControllButton01: View {
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
    }
}
