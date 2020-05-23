//
//  DisplaySettings.swift
//  aligntime
//
//  Created by Ostap on 17/05/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct DisplaySettings: View {
    @EnvironmentObject var user_data: AlignTime
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Divider()
            Toggle(isOn: self.$user_data.show_current_date) {
                Text(NSLocalizedString("Show current date",comment:""))
                    .foregroundColor(.accentColor)
                    .font(.headline)
            }
            .padding(15)
            Divider()
            Spacer()
        }
        //.padding(.horizontal, 20)
        .navigationBarTitle(Text(NSLocalizedString("Display Settings",comment:"")), displayMode: .inline)
    }
}
