//
//  RKViewController.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//
import SwiftUI


struct RKViewController: View {
    @EnvironmentObject var core_data: AlignTime
    @State private var isAnimation = false
    @State private var eege = Edge.trailing
    @State var direction:Bool = true
    @State var show_modal = false
    
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    
    func getMonthHeader() -> String {
        let headerDateFormatter = DateFormatter()
        headerDateFormatter.calendar = self.core_data.calendar
        headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy LLLL", options: 0, locale: self.core_data.calendar.locale)
        
        return headerDateFormatter.string(from: firstOfMonthForOffset()).uppercased()
    }
    
    func firstOfMonthForOffset() -> Date {
        var offset = DateComponents()
        offset.month = self.core_data.selected_month
        
        return self.core_data.calendar.date(byAdding: offset, to: RKFirstDateMonth())!
    }
    
    func RKFirstDateMonth() -> Date {
        var components = self.core_data.calendar.dateComponents(calendarUnitYMD, from: core_data.minimumDate)
        components.day = 1
        
        return self.core_data.calendar.date(from: components)!
    }
    
    var body: some View {
        Group() {
            ZStack(alignment: .top){
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(.accentColor)
                VStack {
                    HStack {
                        HStack{
                            Button("<  ") {
                                self.core_data.selected_month -= 1;
                                self.direction = false
                                withAnimation {
                                    self.isAnimation.toggle()
                                }
                            }
                            .foregroundColor(Color(UIColor.systemBackground))
                        }
                        Button(action: {self.core_data.expanded_calendar.toggle()}) {
                            Text(self.getMonthHeader())
                                .foregroundColor(Color(UIColor.systemBackground))
                                .font(.system(size:20))
                                .frame(width: 170)
                                .padding(.horizontal,10)
                        }
                        Button("  >") {
                            self.core_data.selected_month += 1;
                            self.direction = true
                            withAnimation {
                                self.isAnimation.toggle()
                            }
                        }
                        .foregroundColor(Color(UIColor.systemBackground))
                    }
                    Divider()
                    RKWeekdayHeader()
                        .padding(.horizontal,4)
                    if isAnimation {
                        RKMonth(cell_text_color: Color(UIColor.systemBackground), monthOffset: self.core_data.selected_month).transition(self.direction ? forward_transition : backward_transition)
                    }
                    else
                    {
                        RKMonth(cell_text_color: Color(UIColor.systemBackground), monthOffset: self.core_data.selected_month).transition(self.direction ? forward_transition : backward_transition)
                    }
                    Spacer()
                }
                .padding(.top,10)
                .padding(.horizontal,10)
            }
            .padding(.horizontal,0)
            .frame(height: 320)
        }
        .sheet(isPresented: self.$core_data.expanded_calendar) {
            TestController()
                .environmentObject(self.core_data)
        }
    }
}

struct TestController: View {
    @EnvironmentObject var core_data: AlignTime
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    
    func firstOfMonthForOffset(index:Int) -> Date {
        var offset = DateComponents()
        offset.month = index
        
        return self.core_data.calendar.date(byAdding: offset, to: RKFirstDateMonth())!
    }
    
    func getMonthHeader(index:Int) -> String {
        let headerDateFormatter = DateFormatter()
        headerDateFormatter.calendar = self.core_data.calendar
        headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy LLLL", options: 0, locale: self.core_data.calendar.locale)
        
        return headerDateFormatter.string(from: firstOfMonthForOffset(index:index)).uppercased()
    }
    
    func RKFirstDateMonth() -> Date {
        var components = self.core_data.calendar.dateComponents(calendarUnitYMD, from: core_data.minimumDate)
        components.day = 1
        
        return self.core_data.calendar.date(from: components)!
    }
    
    var body: some View {
        Group {
            //RKWeekdayHeader()
            Text("")
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(Color.blue)
                .background(Color.blue)
            Divider()
            List {
                ForEach(self.core_data.selected_month..<self.core_data.selected_month+3) { index in
                    Text(self.getMonthHeader(index:index))
                        .foregroundColor(Color.blue)
                        .font(.system(size:20))
                        .frame(width: 170)
                        .padding(.horizontal,10)
                    RKMonth(monthOffset: index)
                }
            }
        }
    }
}
