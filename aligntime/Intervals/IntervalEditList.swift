//
//  WearEditFields.swift
//  aligntime
//
//  Created by Ostap on 7/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

func get_1970()->Date{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    return formatter.date(from: "1970/01/01")!
}

struct IntervalEditList: View {
    @EnvironmentObject var core_data: AlignTime
    @Binding var navigation_label:String
    @Binding var dismiss:Bool
    @State var showing_picker = false
    @State var day_index = 0
    @State var min_time:Date = get_1970()
    @State var max_time:Date = Date()
    @State var t:Date = Date()
    
    func get_filtered()-> [DayInterval]{
        if navigation_label == "Wear Times"{
            return self.core_data.get_wear_days()
        }
        return self.core_data.get_off_days()
    }
    

    var body: some View {
        NavigationView {
            VStack{
                HStack(spacing:0){
                List {
                    ForEach(get_filtered()) { i in
                        HStack(alignment: .lastTextBaseline){
                            Spacer()
                            Button(action: {
                                self.day_index = i.id
                                self.showing_picker=true
                                self.t = i.time
                            }){
                                HStack(alignment: .center){
                                    Text(i.time_string)
                                    Text("-")
                                    if (self.core_data.intervals.count<=i.id+1){
                                        Text(NSLocalizedString("Now",comment:""))
                                    }
                                    else{
                                        Text("\(self.core_data.intervals[i.id+1].time_string)")
                                    }
                                }
                                .frame(width: 270)
                            }
                            Spacer()
                            Image(systemName: "pause")
                                .padding(.trailing,5)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: delete)
                }
                //.buttonStyle(PlainButtonStyle())
                .navigationBarItems(
                    trailing: Button(action: add_off_event, label: {
                        Image(systemName: "plus")
                            .font(.system(size: 20))
                            .padding()})
                )
                .navigationBarTitle(Text("\(self.navigation_label)"),displayMode: .inline)
                }
                Button(action: {
                    self.dismiss = false
                }){
                    ZStack(alignment: .center){
                        Rectangle()
                           .frame(height: 35)
                           .foregroundColor(Color.blue)
                        Text(NSLocalizedString("Return",comment:""))
                            .foregroundColor(Color.white)
                            .font(.body)
                    }
                }
            }
            .sheet(isPresented: self.$showing_picker, onDismiss: {
                self.core_data.reasign_intervals_date_id()
                self.core_data.force_event_order()}) {
                TimePicker(dismiss:self.$showing_picker,event_id:self.$day_index).environmentObject(self.core_data)
            }
        }
    }
    
    func get_first_event_for_selected_date()->DayInterval{
        let start_of_day = Calendar.current.startOfDay(for: self.core_data.selected_date)

        var components = DateComponents()
        components.day = 1
        components.second = -1
            
        let end_of_day = Calendar.current.date(byAdding: components, to: start_of_day)!
        let previous_intervals = self.core_data.intervals.filter{ $0.time < end_of_day}
        return previous_intervals.last
    }

    func add_off_event() {
        let new_event = get_first_event_for_selected_date()
        do {
            try self.core_data.add_new_event(event_time:new_event.time,wear_state:new_event.wear)
        } catch {
            print("Can't add new event")
        }
    }
    
    func delete(at offsets: IndexSet) {
        if self.core_data.intervals.count==2{
             return
        }
        
        let interval_index = self.get_filtered()[offsets.first!].id
        
        if self.core_data.intervals.count > interval_index{
            self.core_data.intervals.remove(at: interval_index)
        }
        if self.core_data.intervals.count > interval_index{
            self.core_data.intervals.remove(at: interval_index)
        }
        self.core_data.reasign_intervals_id()
    }
}

