//
//  WearEditFields.swift
//  aligntime
//
//  Created by Ostap on 7/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

func get_min_time()->Date{
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
    @State var min_time:Date = get_min_time()
    @State var max_time:Date = Date()
    @State var t:Date = Date()
    
    func get_filtered()-> [DayInterval]{
        if navigation_label == "Wear Times"{
            return self.core_data.get_wear_days()
        }
        return self.core_data.get_off_days()
    }
    
    func get_filtered_all()-> [DayInterval]{
        let combined = self.core_data.get_wear_days() + self.core_data.get_off_days()
        return combined
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
                                            .padding(.horizontal,2)
                                    }
                                    else{
                                        Text("\(self.core_data.intervals[i.id+1].time_string)")
                                            .padding(.horizontal,2)
                                    }
                                }
                                .frame(width: 300)
                            }
                            Spacer()
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
                    }
                }
            }
            .sheet(isPresented: self.$showing_picker, onDismiss: {
                self.core_data.remove_interesected_events(event_index: self.day_index)
            }
            ) {
                TimePicker(dismiss:self.$showing_picker,event_id:self.day_index).environmentObject(self.core_data)
            }
        }
    }

    func add_off_event() {
        let unsorted = get_filtered_all()
        let sorted = unsorted.sorted(by: { $0.id < $1.id })
        
        self.core_data.add_new_event(to:sorted)
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

