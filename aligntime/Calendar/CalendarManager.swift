//
//  Calendar.swift
//  aligntime
//
//  Created by Ostap on 23/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI


struct CalendarManager: View {
    @EnvironmentObject var core_data: AlignTime
    var isAnimation:Bool = true
   
    var body: some View {
        VStack(alignment: .center) {
            //Text("event count: \(self.core_data.intervals.count)")
            RKViewController()
            AlignerNoticion()
            IntervalFields()
                //.padding(.top, 20)
                .padding(.horizontal, 30)
                .animation(.spring())
            Spacer()
        }.onAppear(perform: startUp)
    }
       
    func startUp() {
            self.core_data.selected_date = Date()
            core_data.update_min_max_dates()
            // example of some foreground colors
            core_data.colors.weekdayHeaderColor = Color.white
            core_data.colors.monthHeaderColor = Color.green
            core_data.colors.textColor = Color.blue
            core_data.colors.disabledColor = Color.red

        self.core_data.selected_month = Calendar.current.dateComponents(in: .autoupdatingCurrent, from: Date()).month ?? 0
       }
}

struct AlignerNoticion: View {
    @EnvironmentObject var core_data: AlignTime
    @State var days:Int = 0
    var raw_days:Int = 0
    
    func show_aligner_number(date:Date)->Bool{
        let (aligner,aligner_day) = self.core_data.get_expected_aligner_for_date(date:self.core_data.selected_date)
        //print("aligner",aligner,aligner_day)
        if self.core_data.is_last_day_for_aligner(aligner:aligner,
                                                  day_count:aligner_day){
            return true
        }
        return false
    }
    
    func is_last_day(date:Date)->Bool{
        let (aligner,_) = self.core_data.get_expected_aligner_for_date(date:self.core_data.selected_date)

        if aligner==self.core_data.required_aligners_total{return true}
        return false
    }
    
    func get_aligner(date:Date)->Int{
        let (aligner,_) = self.core_data.get_expected_aligner_for_date(date:self.core_data.selected_date)
        return aligner
    }

    var body: some View {
        VStack(){
            if !self.core_data.is_in_wear_time_target(date: self.core_data.selected_date){
                HStack(){
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.orange, lineWidth: 1)
                        .frame(width: 10, height: 10)
                        .padding(.leading,8)
                    Text(NSLocalizedString("Out of daily wear time target",comment:""))
                    Spacer()
                }
            }
            HStack(){
                if show_aligner_number(date: self.core_data.selected_date){
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 5, height: 5)
                        .padding(.leading,10)
                        .foregroundColor(self.is_last_day(date: self.core_data.selected_date) ? Color.orange : Color.accentColor)
                    Group{
                        if self.is_last_day(date: self.core_data.selected_date){
                            HStack(spacing:2){
                                Text(NSLocalizedString("Today",comment:""))
                                Text(NSLocalizedString("congratulations",comment:""))
                            }
                        }
                        else{
                            Text(NSLocalizedString("Last day for aligner",comment:""))
                                + Text(" #\(get_aligner(date: self.core_data.selected_date)+1)")
                        }
                    }
                }
                Spacer()
            }
        }
        .font(.footnote)
        .foregroundColor(.accentColor)
    }
}

