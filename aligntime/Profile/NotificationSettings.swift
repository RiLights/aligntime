//
//  NotificationSettings.swift
//  aligntime
//
//  Created by Ostap on 25/05/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct NotificationSettings: View {
    @EnvironmentObject var user_data: AlignTime
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            VStack{
                Text(NSLocalizedString("Changer aligner time notification",comment:""))
                    .font(.headline)
                    .foregroundColor(.blue)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                DatePicker(selection: $user_data.aligner_time_notification, displayedComponents: .hourAndMinute) {
                    Text("Changer aligner time notification")
                }
                .labelsHidden()
            }
            .padding(.top, 20)
            Spacer()
        }
        .navigationBarTitle(Text(NSLocalizedString("Notification Settings",comment:"")), displayMode: .inline)
    }
}

