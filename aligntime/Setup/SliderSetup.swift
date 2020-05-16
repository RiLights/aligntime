//
//  SliderSetup.swift
//  aligntime
//
//  Created by Ostap on 17/05/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct SliderSetup: View {
    var label:String = "Undefined"
    var min:Float = 1
    var max:Float = 2
    @Binding var slider_value:Float
    
    var body: some View {
        VStack(alignment: .center){
            Group{
                Text(NSLocalizedString(label,comment:""))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("\(Int(slider_value))")
                    .foregroundColor(.blue)
            }
            .font(.headline)
            Slider(value: self.$slider_value, in: min...max, step: 1)
            Spacer()
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 30)
        .navigationBarTitle("Additional Settings",displayMode: .inline)
    }
}
