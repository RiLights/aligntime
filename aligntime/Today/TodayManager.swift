//
//  Today.swift
//  aligntime
//
//  Created by Ostap on 27/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI


struct TodayManager: View {
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
