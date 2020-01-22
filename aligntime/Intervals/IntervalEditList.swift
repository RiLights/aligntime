//
//  WearEditFields.swift
//  aligntime
//
//  Created by Ostap on 7/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI



struct IntervalEditList: View {
    @EnvironmentObject var core_data: AlignTime
    @Binding var navigation_label:String
    @State var showing_picker = false
    @State var show_end_time_state:Bool = false
    @State var day_index = 0
    
    func get_filtered()->[DayInterval]{
        if navigation_label == "Wear Times"{
            return self.core_data.get_wear_day_list()
        }
        return self.core_data.get_off_day_list()
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
                trailing: Button(action: addTimeInterval, label: { Text("Add") })
            )
            .navigationBarTitle(self.navigation_label)
            }
            .sheet(isPresented: self.$showing_picker) {
                TimePicker(date_time: self.$core_data.intervals[self.day_index].time)
            }
        }
    }

    func addTimeInterval() {print("not ready yet")}
    func delete(at offsets: IndexSet) {
        let interval_index = self.get_filtered()[offsets.first!].id
        
        print(interval_index)
        self.core_data.intervals.remove(at: interval_index)
        self.core_data.intervals.remove(at: interval_index)
        self.core_data.reasign_intervals_id()
        //self.intervals.remove(atOffsets: offsets)
    }
}

