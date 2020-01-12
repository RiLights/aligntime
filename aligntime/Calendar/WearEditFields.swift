//
//  WearEditFields.swift
//  aligntime
//
//  Created by Ostap on 7/01/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI


struct WearEditFields: View {
    @EnvironmentObject var core_data: AlignTime
    //@State var string_intervals = [["00:00","07:00"], ["12:00","13:00"]]
    @Binding var navigation_label:String
    @State var showing_picker = false
    @State var show_end_time_state:Bool = false
    @State var day_index = 0

    var body: some View {

        NavigationView {
            List {
                ForEach(core_data.day_intervals) { i in
                    HStack(alignment: .center){
                        Spacer()
                        Button(action: {
                            if (i.start_time_string != "     ...."){
                                self.show_end_time_state = false
                                self.day_index = i.id
                                
                                //min,max assigment
                                if i.id != 0 {
                                    self.core_data.day_intervals[self.day_index].min_time = self.core_data.day_intervals[self.day_index-1].end_time
                                }
                                if (i.end_time_string != "....     "){
                                    self.core_data.day_intervals[self.day_index].max_time = i.end_time
                                }
                                self.showing_picker.toggle()
                            }
                        }){
                            Text(i.start_time_string)
                                .frame(width: 50)
                                .padding(.horizontal,5)
                        }
                        Text("-")
                        Button(action: {
                            if (i.end_time_string != "....     "){
                                self.show_end_time_state = true
                                self.day_index = i.id
                                
                                //min,max assigment
                                //print("mi",self.core_data.day_intervals.count,i.id)
                                if i.id != self.core_data.day_intervals.count  {
                                    self.core_data.day_intervals[self.day_index].max_time = self.core_data.day_intervals[self.day_index+1].start_time
                                }
                                if (i.start_time_string != "     ...."){
                                    self.core_data.day_intervals[self.day_index].min_time = i.start_time
                                }
                                
                                self.showing_picker.toggle()
                            }
                        }){
                            Text(i.end_time_string)
                                .frame(width: 50)
                                .padding(.horizontal,5)
                        }
                        Spacer()
                    }
                
                }
                .onDelete(perform: delete)
                .buttonStyle(PlainButtonStyle())
            }
            //.navigationBarItems(trailing: EditButton())
            .navigationBarItems(
                  trailing: Button(action: addTimeInterval, label: { Text("Add") })
            )
            .navigationBarTitle(self.navigation_label)
            .sheet(isPresented: $showing_picker) {
                if self.show_end_time_state{
                    TimePicker(date_time: self.$core_data.day_intervals[self.day_index].end_time,
                               min_time:self.$core_data.day_intervals[self.day_index].min_time,
                               max_time:self.$core_data.day_intervals[self.day_index].max_time)
                }
                else{
                    TimePicker(date_time: self.$core_data.day_intervals[self.day_index].start_time,
                               min_time:self.$core_data.day_intervals[self.day_index].min_time,
                               max_time:self.$core_data.day_intervals[self.day_index].max_time)

                }
            }
        }
        
    }

    func addTimeInterval() {print("not ready yet")}
    func delete(at offsets: IndexSet) {
        core_data.day_intervals.remove(atOffsets: offsets)
    }
}

