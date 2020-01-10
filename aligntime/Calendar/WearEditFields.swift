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
    @State var showing_picker = false
    @State var show_end_time_state:Bool = false
    @State var day_index = 0

    var body: some View {

        NavigationView {
            List {
                ForEach(core_data.day_intervals.reversed()) { i in
                    HStack(alignment: .center){
                        Spacer()
                        Button(action: {
                            self.show_end_time_state = false
                            self.day_index = i.id
                            print(i.id)
                            self.showing_picker.toggle()
                        }){
                            Text(i.start_time_string)
                                .frame(width: 50)
                                .padding(.horizontal,5)
                        }
                        Text("-")
                        Button(action: {
                            self.show_end_time_state = true
                            self.day_index = i.id
                            self.showing_picker.toggle()
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
            .navigationBarTitle("Wear Times")
            .sheet(isPresented: $showing_picker) {
                if self.show_end_time_state{
                    TimePicker(date_time: self.$core_data.day_intervals[self.day_index].end_time)
                }
                else{
                    TimePicker(date_time: self.$core_data.day_intervals[self.day_index].start_time)

                }
            }
        }
        
    }

    func addTimeInterval() {print("not ready yet")}
    func delete(at offsets: IndexSet) {
        core_data.day_intervals.remove(atOffsets: offsets)
    }
}

