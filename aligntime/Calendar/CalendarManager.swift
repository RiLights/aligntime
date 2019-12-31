//
//  Calendar.swift
//  aligntime
//
//  Created by Ostap on 23/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI


struct CalendarManager: View {
     
       @State var singleIsPresented = false
       @State var startIsPresented = false
       @State var multipleIsPresented = false
       @State var deselectedIsPresented = false
       
       var rkManager1 = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0)
   
       var body: some View {
        
           VStack (spacing: 25) {
                   RKViewController(isPresented: self.$singleIsPresented, rkManager: self.rkManager1)
           }.onAppear(perform: startUp)
               .navigationViewStyle(StackNavigationViewStyle())
       }
       
       func startUp() {
         let testOnDates = [Date().addingTimeInterval(60*60*24), Date().addingTimeInterval(60*60*24*2)]
         rkManager1.selectedDates.append(contentsOf: testOnDates)
         
         // example of some foreground colors
         rkManager1.colors.weekdayHeaderColor = Color.blue
         rkManager1.colors.monthHeaderColor = Color.green
         rkManager1.colors.textColor = Color.blue
         rkManager1.colors.disabledColor = Color.red
       }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarManager()
    }
}
