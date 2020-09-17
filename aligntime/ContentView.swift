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
        Group{
            if user_data.complete == true {
                Home().environmentObject(user_data)
                //ContentView4()
                //StatisticsView().environmentObject(user_data)
                //Welcome().environmentObject(user_data)
            }
            else{
                Welcome().environmentObject(user_data)
            }
        }
    }
}

struct ContentView2: View {

//    init(){
//        UITableView.appearance().backgroundColor = .clear
//    }
    
    var min:Int = 1
    var max:Int = 2
    @Binding var slider_value:Int
    
    var strengths = ["Mild", "Medium", "Mature"]

    @State private var selectedStrength = 0

    //@State var value = ""

    var body: some View {
        Form {
            Section(header: Text("How many aligners do you require?")) {
                Picker(selection: self.$slider_value, label: Text("hello")) {
                    ForEach((min...max), id: \.self) {
                        Text("\($0)")
                    }
                }//.pickerStyle(WheelPickerStyle())
            }
        }
        .foregroundColor(Color.blue)
        .background(Color.clear)
        .navigationBarTitle("Select your cheese",displayMode: .inline)
    }
}

