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
    
    func get_min_days_for_aligner(aligner_id:Int)->Int{
        if self.user_data.aligners[aligner_id].aligner_number == Int(self.user_data.aligner_number_now){
            return Int(self.user_data.days_wearing)
        }
        return 1
    }
    
    var body: some View {
        List {
            ForEach(user_data.aligners) { aligner in
                if aligner.aligner_number >= Int(self.user_data.aligner_number_now){
                    Stepper(String(format: NSLocalizedString("Aligner # %d: %d Day(s)",comment: ""),aligner.aligner_number,aligner.days), value: self.$user_data.aligners[aligner.id].days,
                            in: self.get_min_days_for_aligner(aligner_id:aligner.id)...20)
                }
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
