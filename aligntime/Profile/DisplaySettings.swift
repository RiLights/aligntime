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
    @State var test:Bool=true
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Divider()
            Toggle(isOn: $user_data.show_expected_aligner) {
                Text(NSLocalizedString("Show expected aligner",comment:""))
                    .foregroundColor(.accentColor)
                    .font(.headline)
            }
            .padding(.top,20)
            Divider()
            Toggle(isOn: $test) {
                Text(NSLocalizedString("Show current data",comment:""))
                    .foregroundColor(.accentColor)
                    .font(.headline)
            }
            .padding(.top,20)
            Divider()
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationBarTitle(Text(NSLocalizedString("Display Settings",comment:"")), displayMode: .inline)
    }
}
