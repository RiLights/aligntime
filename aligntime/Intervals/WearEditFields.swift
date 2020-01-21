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
    @Binding var navigation_label:String
    @State var showing_picker = false
    @State var show_end_time_state:Bool = false
    @State var day_index = 0
    @Binding var intervals:[DayInterval]
    
    func get_filtered()->[DayInterval]{
        return self.intervals.filter{$0.wear == true}
    }

    var body: some View {
        NavigationView {
            HStack(spacing:0){
            List {
                ForEach(core_data.get_wear_day_list()) { i in
                    HStack(alignment: .lastTextBaseline){
                        Spacer()
                        Button(action: {
//                            if (i.start_time_string != "     ...."){
//                                self.show_end_time_state = false
//                                self.day_index = i.id
//                                i.max_time = i.end_time
                                self.day_index = i.id
                                self.showing_picker.toggle()
                            
                        }){
                            Text(i.time_string)
                                //.frame(width: 50)
                                //.padding(.horizontal,5)
                                //.padding(.trailing,5)
                        }
                        Text(":")                        
                    }
                }
                .onDelete(perform: delete)
            }
                //Text("-")
                //Spacer()
            List {
                ForEach(get_filtered()) { i in
                    HStack(alignment: .center){
                        //Spacer()
                        Text(":")
                        Button(action: {

                                
                                self.showing_picker.toggle()
                            
                        }){
                            Text(i.time_string)
                                //.frame(width: 50)
                                //.padding(.horizontal,5)
                        }
                        Spacer()
                    }
                }
                .onDelete(perform: delete)
            }
                //.navigationBarItems(trailing: EditButton())
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
        print(offsets.first!)
        //self.intervals.remove(atOffsets: offsets)
    }
}

