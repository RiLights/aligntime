//
//  IndividualAligner.swift
//  aligntime
//
//  Created by Ostap on 19/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct IndividualAlignerManager: View {
    @EnvironmentObject var user_data: AlignTime
    @State var locations = [1, 2, 3]
    @State var test_number = 7
    
    var body: some View {
        List {
            ForEach(user_data.aligners) { aligner in
                //Text("\(user_data.aligner_number_now)")
//                VStack{
//                    HStack{
//                        Text("Aligner #\(aligner.aligner_number)")
//                        //TextField("",value:self.$user_data.aligners[aligner.id].aligner_number,formatter: NumberFormatter())
//                        Spacer()
//                        Text("Day \(aligner.days)")
//                    }
//                    //Stepper("Day \(aligner.days)", value: self.$user_data.aligners[aligner.id].days, in: 1...20)
//                }
                Stepper("Aligner #\(aligner.aligner_number): Day \(aligner.days)", value: self.$user_data.aligners[aligner.id].days, in: 1...20)
            }
            //.onDelete { _ in }
        }
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
        let count = self.user_data.aligners.count
        let v = IndividualAligner(count,days:7,aligner_number:count+1)
        self.user_data.aligners.append(v)
    }
}
