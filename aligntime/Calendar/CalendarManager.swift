//
//  Calendar.swift
//  aligntime
//
//  Created by Ostap on 23/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI


struct CalendarManager: View {
    @EnvironmentObject var core_data: AlignTime
    var isAnimation:Bool = true
   
    var body: some View {
        VStack(alignment: .center) {
            RKViewController()
            IntervalFields()
                .padding(.top, 20)
                .padding(.horizontal, 40)
                .animation(.spring())
            Spacer()
        }.onAppear(perform: startUp)
    }
       
    func startUp() {
         // example of some foreground colors
         core_data.colors.weekdayHeaderColor = Color.white
         core_data.colors.monthHeaderColor = Color.green
         core_data.colors.textColor = Color.blue
         core_data.colors.disabledColor = Color.red
       }
}
