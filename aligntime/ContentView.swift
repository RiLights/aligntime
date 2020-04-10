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
    //let hours:[Int] = [0,3,6,9,12,15,18,21,24]
    
    var body: some View {
        StatisticsView()
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

