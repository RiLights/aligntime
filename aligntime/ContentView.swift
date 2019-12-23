//
//  ContentView.swift
//  aligntime
//
//  Created by Ostap on 26/11/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct ContentView: View {
       @State private var selection = 0
    
       var body: some View {
           TabView(selection: $selection){
               Text("Today")
                   .font(.title)
                   .tabItem {
                       VStack {
                           Text("First")
                       }
                   }
                   .tag(0)
               Text("History")
                   .font(.title)
                   .tabItem {
                       VStack {
                           Text("Second")
                       }
                   }
                   .tag(1)
                Text("More")
                    .font(.title)
                    .tabItem {
                        VStack {
                            Text("Second")
                        }
                    }
                    .tag(2)
           }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
