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
    @State var showing_picker = false
    @State var show_end_time_state:Bool = false
    @State var day_index = 0
    @State var min_time:Date = get_min_time()
    @State var max_time:Date = Date()
    
    func get_filtered()-> [DayInterval]{
        if navigation_label == "Wear Times"{
            return self.core_data.get_wear_days()
        }
        return self.core_data.get_off_days()
    }

    var body: some View {
        NavigationView {
            HStack(spacing:0){
            List {
                ForEach(get_filtered()) { i in
                    HStack(alignment: .lastTextBaseline){
                        Spacer()
                        Button(action: {
                            self.day_index = i.id
                            if i.id != 0{
                                self.min_time = self.core_data.intervals[i.id-1].time
                            }
                            if (self.core_data.intervals.count>i.id+1){
                                self.max_time = self.core_data.intervals[i.id+1].time
                            }
                            
                            self.showing_picker.toggle()
                            
                        }){
                            Text(i.time_string)
                                .frame(width: 50)
                        }
                        Text("-")
                        Button(action: {
                            if (self.core_data.intervals.count<=i.id+1){
                            }
                            else{
                                self.day_index = i.id+1
                                self.min_time = i.time
                                if (self.core_data.intervals.count>i.id+2){
                                    self.max_time = self.core_data.intervals[i.id+2].time
                                }
                                else{
                                    self.max_time = Date()//self.core_data.intervals[i.id+1].time
                                }
                                self.showing_picker.toggle()
                            }
                            
                        }){
                            if (self.core_data.intervals.count<=i.id+1){
                                Text("Now")
                                    .frame(width: 50)
                                    .padding(.horizontal,2)
                            }
                            else{
                                Text("\(self.core_data.intervals[i.id+1].time_string)")
                                    .frame(width: 50)
                                    .padding(.horizontal,2)
                            }
                        }
                        Spacer()
                    }
                }
                .onDelete(perform: delete)
            }
            .buttonStyle(PlainButtonStyle())
            .navigationBarItems(
                trailing: Button(action: addOffEvent, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20))
                        .padding()})
            )
            .navigationBarTitle(self.navigation_label)
            }
            .sheet(isPresented: self.$showing_picker) {
                TimePicker(date_time: self.$core_data.intervals[self.day_index].time,
                           min_time:self.$min_time,
                           max_time:self.$max_time)
            }
        }
    }

    func addOffEvent() {
        let d = DayInterval(self.core_data.intervals.count,
                            wear: false, time: Date())
        self.core_data.intervals.append(d)
        print("not ready yet")
    }
    func delete(at offsets: IndexSet) {
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

