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
    
    var body: some View {
        List {
            ForEach(user_data.aligners) { aligner in
                Stepper(String(format: NSLocalizedString("Aligner # %d: %d Day(s)",comment: ""),aligner.aligner_number,aligner.days), value: self.$user_data.aligners[aligner.id].days, in: 1...20)
            }
        }
        .navigationBarTitle(Text(NSLocalizedString("Aligner Adjustment",comment:"")))
    }
    private func addRow() {
        let count = self.user_data.aligners.count
        let v = IndividualAligner(count,days:7,aligner_number:count+1)
        self.user_data.aligners.append(v)
    }
}
