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
    //@State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        //TestV()
        Group{
            if user_data.complete == true {
                Home().environmentObject(user_data)
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
