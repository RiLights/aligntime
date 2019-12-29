//
//  Calendar.swift
//  aligntime
//
//  Created by Ostap on 23/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct CalendarManager: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Rectangle()
                .border(Color.white, width: 1)
                .frame(width: 200, height: 200)
                .foregroundColor(.blue)
            Text("That Is Calendar")
            Spacer()
        }
    }
}

