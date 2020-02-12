//
//  Today.swift
//  aligntime
//
//  Created by Ostap on 27/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

func timer_format(_ second: TimeInterval) -> String? {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.zeroFormattingBehavior = .pad
    return formatter.string(from: second)
}

struct TodayManager: View {    
    var body: some View {
        VStack(alignment: .center) {
            TodayHeader()
            Spacer()
            TodayTimer()
            Spacer()
            TodayDaysLeft()
        }
    }
}
