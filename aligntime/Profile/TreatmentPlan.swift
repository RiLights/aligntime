//
//  TreatmentPlan.swift
//  aligntime
//
//  Created by Ostap on 18/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//
import SwiftUI

struct TreatmentPlan: View {
    @EnvironmentObject var user_data: AlignTime
    let g_opacity = 0.1
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Group{
                //Divider()
                InitSetup01Base()
                    .padding(.horizontal, 15)
                    .padding(.top, 10)
                    .background(Color.secondary.opacity(g_opacity))
                //Divider()
                Spacer()
                    .frame(height: 30)
                InitSetup02Base()
                    .padding(.top, 10)
                    .padding(.horizontal, 15)
                    .background(Color.secondary.opacity(g_opacity))
                Spacer()
                    .frame(height: 30)
                LinkSubMenu(icon: "list.bullet.indent", label: NSLocalizedString("Individual Aligner Adjust",comment: ""), destination: IndividualAlignerManager())
                    .padding(.horizontal, 15)
                    .background(Color.secondary.opacity(g_opacity))
            }
            
                //.padding(.vertical, 15)
                    
                //.padding(.horizontal, 15)
            Spacer()
            //LinkMenu(icon: "list.bullet.indent", label: NSLocalizedString("Individual Aligner Adjust",comment: ""), destination: IndividualAlignerManager())
//                DataCollect01Body()
//                    .padding(.top, 10)
//                Toggle(isOn: $user_data.show_current_date) {
//                    Text(NSLocalizedString("Show expected aligner",comment:""))
//                        .foregroundColor(.accentColor)
//                        .font(.headline)
//                }
//                .padding(.horizontal, 40)
//                .padding(.bottom,30)
//                DataCollect02Body()
//                VStack(alignment: .center){
//                     Text(NSLocalizedString("Changer aligner time notification",comment:""))
//                         .font(.headline)
//                         .foregroundColor(.blue)
//                         .fixedSize(horizontal: false, vertical: true)
//                         .multilineTextAlignment(.center)
//                     DatePicker(selection: $user_data.aligner_time_notification, displayedComponents: .hourAndMinute) {
//                             Text("Changer aligner time notification")
//                         }
//                         .labelsHidden()
//                 }
//                 .padding(.horizontal, 40)
//                .padding(.top,30)
            
            
        }
        .navigationBarTitle(Text(NSLocalizedString("Treatment Plan",comment:"")), displayMode: .inline)
    }
}

