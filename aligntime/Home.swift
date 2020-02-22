//
//  Home.swift
//  aligntime
//
//  Created by Ostap on 23/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var user_data: AlignTime
    @State private var selection = 1
    
    @State var showingProfile = false
    @State var isNavigationBarHidden: Bool = true
    
    var profileButton: some View {
        Button(action: { self.showingProfile.toggle() }) {
            Image(systemName: "person.crop.circle")
                .font(.system(size: 26))
                //.imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    var body: some View {
        NavigationView {
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

               CalendarManager()
                   .font(.title)
                   .tabItem {
                       VStack {
                           Text("Calendar")
                           Image(systemName: "calendar")
                       }
                   }
                   .tag(1)
           }
            .accentColor(.blue)
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile) {
                ProfileManager().environmentObject(self.user_data)
            }
            .gesture(DragGesture()
//            .onEnded({ (value) in
//                if (value.translation.width > 0){
//                    if (value.translation.width > 100) && (self.selection>=1){
//                        self.selection-=1
//                    }
//                }
//                else{
//                    if (value.translation.width < -100) && (self.selection<=1){
//                        self.selection+=1
//                    }
//                }
//            })
            )
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}
