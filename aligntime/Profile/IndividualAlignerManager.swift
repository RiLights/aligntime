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
                Stepper("Aligner #\(aligner.aligner_number): Day \(aligner.days)", value: self.$user_data.aligners[aligner.id].days, in: 1...20)
            }
        }
        .navigationBarTitle(Text("Aligner Adjustment"))
    }
    private func addRow() {
        let count = self.user_data.aligners.count
        let v = IndividualAligner(count,days:7,aligner_number:count+1)
        self.user_data.aligners.append(v)
    }
}
