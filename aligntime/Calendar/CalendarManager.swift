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
       var pickup_date = "Pick up the date"
       
       var body: some View {
        
           VStack (spacing: 25) {
                   RKViewController(isPresented: self.$singleIsPresented, rkManager: self.rkManager1)
           }.onAppear(perform: startUp)
               .navigationViewStyle(StackNavigationViewStyle())
       }
       
       func startUp() {
         
           
       }
       
       func getTextFromDate(date: Date!) -> String {
           let formatter = DateFormatter()
           formatter.locale = .current
           formatter.dateFormat = "yyyy.MM.d"
           return date == nil ? "Pick up the date" : formatter.string(from: date)
       }

}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarManager()
    }
}
