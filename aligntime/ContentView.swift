//
//  ContentView.swift
//  aligntime
//
//  Created by Ostap on 26/11/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user_data: AlignTime
    @State private var hideHorizontalLines: Bool = false
    //@State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
//            HStack(alignment: .center){
//                ForEach((0...24), id: \.self) { width in
//                    Text("\(width)")
//                        .foregroundColor(Colors.LegendText)
//                        .font(.caption)
//                        .frame(width:10)
//                }
//            }
            GeometryReader{ geometry in
                Legend(data: ChartData(points: [1200,1000,500,700,750,0,0,150]),
                       frame: .constant(geometry.frame(in: .local)), hideHorizontalLines: self.$hideHorizontalLines)
                    .transition(.opacity)
                    .animation(Animation.easeOut(duration: 1).delay(1))
                Line(data: ChartData(points: [1200,1000,500,700,750,0,0,150]), frame: .constant(geometry.frame(in: .local)), touchLocation: .constant(CGPoint(x: 100, y: 12)), showIndicator: .constant(true), minDataValue: .constant(nil), maxDataValue: .constant(nil),showBackground: true)
            } 
        }
//        Group{
//            if user_data.complete == true {
//                Home().environmentObject(user_data)
//            }
//            else{
//                Welcome().environmentObject(user_data)
//                }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
