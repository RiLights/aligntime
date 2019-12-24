//
//  ContentView.swift
//  aligntime
//
//  Created by Ostap on 26/11/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user_data: UserData
    
    var body: some View {
        Group{
            if user_data.complete == true {
                Home()
            }
            else{
                Init()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
