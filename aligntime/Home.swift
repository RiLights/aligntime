//
//  Home.swift
//  aligntime
//
//  Created by Ostap on 23/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var user_data: UserData
    @State private var selection = 0
    
    @State var showingProfile = false
    
    var profileButton: some View {
        Button(action: { self.showingProfile.toggle() }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    var body: some View {
        Section {
            TabView(selection: $selection){
                TodayManager()
                   .font(.title)
                   .tabItem {
                        VStack {
                            Text("Today")
                            Image(systemName: "bag")
                        }
                   }
                   .tag(0)

               Calendar()
                   .font(.title)
                   .tabItem {
                       VStack {
                           Text("Calendar")
                           Image(systemName: "calendar")
                       }
                   }
                   .tag(1)

                Text("More")
                    .font(.title)
                    .tabItem {
                            Text("More")
                            Image(systemName: "ellipsis.circle")
                    }
                    .tag(2)
           }
            .accentColor(.blue)
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile) {
                ProfileHost().environmentObject(self.user_data)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(false)
    }
}
