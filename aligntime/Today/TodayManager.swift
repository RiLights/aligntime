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
            Divider()
                .padding(.bottom, 20)
            TodayTimer()
            Divider()
                .padding(.top, 30)
            Spacer()
            TodayDaysLeft()
        }
    }
}
