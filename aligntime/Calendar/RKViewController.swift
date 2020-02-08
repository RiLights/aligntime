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
    @State private var monthOffset = Calendar.current.dateComponents(in: .current, from: Date()).month ?? 0
    //@Binding var isPresented: Bool
    @State var isPresented: Bool = false
    @State private var isAnimation = false
    @State private var eege = Edge.trailing
    @State var direction:Bool = true
    
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    
    func getMonthHeader2() -> String {
        let headerDateFormatter = DateFormatter()
        headerDateFormatter.calendar = self.core_data.calendar
        headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy LLLL", options: 0, locale: self.core_data.calendar.locale)
        
        return headerDateFormatter.string(from: firstOfMonthForOffset()).uppercased()
    }
    
    func firstOfMonthForOffset() -> Date {
        var offset = DateComponents()
        offset.month = self.monthOffset
        
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
                                self.monthOffset -= 1;
                                self.direction = false
                                withAnimation {
                                    self.isAnimation.toggle()
                                }
                            }
                            .foregroundColor(Color(UIColor.systemBackground))
                        }
                        Text(self.getMonthHeader2())
                            .foregroundColor(Color(UIColor.systemBackground))
                            .font(.system(size:20))
                            .frame(width: 170)
                            .padding(.horizontal,10)
                        Button("  >") {
                            self.monthOffset += 1;
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
                        RKMonth(isPresented: self.$isPresented, monthOffset: self.monthOffset).transition(self.direction ? forward_transition : backward_transition)
                    }
                    else
                    {
                        RKMonth(isPresented: self.$isPresented, monthOffset: self.monthOffset).transition(self.direction ? forward_transition : backward_transition)
                    }
                    Spacer()
                }
                .padding(.top,10)
                .padding(.horizontal,10)
            }
            .padding(.horizontal,0)
            .frame(height: 320)
        }
    }
    
}
