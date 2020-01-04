//
//  ReminderPopUp.swift
//  aligntime
//
//  Created by Ostap on 4/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import Foundation
import SwiftUI


struct TextFieldAlert<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    @Binding var text: String
    let presenting: Presenting
    let title: Text

    var body: some View {
        ZStack {
            presenting
                .disabled(isShowing)
            VStack {
                //title
                //TextField($text)
                Text("asd")
                Divider()
                HStack {
                    Button(action: {
                        withAnimation {
                            self.isShowing.toggle()
                        }
                    }) {
                        Text("Dismiss")
                    }
                }
            }
            .padding()
            .background(Color.white)
            .shadow(radius: 1)
            .opacity(isShowing ? 1 : 0)
        }
    }

}

extension View {

    func textFieldAlert(isShowing: Binding<Bool>,
                        text: Binding<String>,
                        title: Text) -> some View {
        TextFieldAlert(isShowing: isShowing,
                       text: text,
                       presenting: self,
                       title: title)
    }

}
