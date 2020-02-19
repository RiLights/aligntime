//
//  IndividualAligner.swift
//  aligntime
//
//  Created by Ostap on 19/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct IndividualAligner: View {
    @State var locations = [1, 2, 3]
    @State var test_number = 7
    
    var body: some View {
        List {
            ForEach(locations, id: \.self) { location in
                //Text("\(user_data.aligner_number_now)")
                VStack{
                    HStack{
                        Text("Aligner #\(location)")
                        Spacer()
                    }
                    Stepper("Day \(self.test_number)", value: self.$test_number, in: 1...20)
                }
            }
            .onDelete { _ in }
        }
        //.navigationBarTitle(Text("Locations"))
        // 3.
        .navigationBarItems(trailing: Button(action: {
            self.addRow()
        }) {
            //Text("Add Aligner")
            Image(systemName: "plus")
                .font(.system(size: 20))
                .padding()
        })
//        List {
//          ForEach([
//            "Line 1",
//            "Line 2",
//          ], id: \.self) {
//            item in
//            HStack {
//              Text("\(item)")
//              Spacer()
//              Button(action: { print("\(item) 1")}) {
//                Text("Button 1")
//              }
//              Button(action: { print("\(item) 2")}) {
//                Text("Button 2")
//              }
//            }
//          }
//          .onDelete { _ in }
//          .buttonStyle(BorderlessButtonStyle())
//        }
        //.navigationBarItems(trailing: EditButton())
            .navigationBarTitle(Text("Aligner Adjustment"))
    }
    private func addRow() {
        self.locations.append(7)
    }
}
