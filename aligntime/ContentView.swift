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
    
    var body: some View {
        Group{
            if user_data.complete == true {
                NavigationView {
                    Home().environmentObject(user_data)
                }
            }
            else{
                Welcome().environmentObject(user_data)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
