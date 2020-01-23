//
//  RKViewController.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//
import SwiftUI


struct RKViewController: View {
    
    @State private var monthOffset = 0
    @Binding var isPresented: Bool
    @State private var isAnimation = false
    @State private var eege = Edge.trailing
    @State var direction:Bool = true
    
    @ObservedObject var rkManager: RKManager
    
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    func getMonthHeader2() -> String {
        let headerDateFormatter = DateFormatter()
        headerDateFormatter.calendar = rkManager.calendar
        headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy LLLL", options: 0, locale: rkManager.calendar.locale)
        
        return headerDateFormatter.string(from: firstOfMonthForOffset()).uppercased()
    }
    
    func firstOfMonthForOffset() -> Date {
        var offset = DateComponents()
        offset.month = self.monthOffset
        
        return rkManager.calendar.date(byAdding: offset, to: RKFirstDateMonth())!
    }
    
    func RKFirstDateMonth() -> Date {
        var components = rkManager.calendar.dateComponents(calendarUnitYMD, from: rkManager.minimumDate)
        components.day = 1
        
        return rkManager.calendar.date(from: components)!
    }
    
    var body: some View {
        Group() {
            ZStack(alignment: .top){
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.accentColor)
                VStack {
                    HStack {
                        Spacer()
                        HStack{
                            Button("< ") {
                                self.monthOffset -= 1;
                                //forward_transition.combined(with: backward_transition)
                                //self.transition = forward_transition
                                //self.eege = Edge.leading
                                self.direction = false
                                withAnimation {
                                    self.isAnimation.toggle()
                                }
                            }
                            .foregroundColor(.white)
                            Button(" >") {
                                self.monthOffset += 1;
                                //transition = backward_transition
                                //self.eege = Edge.trailing
                                self.direction = true
                                withAnimation {
                                    self.isAnimation.toggle()
                                }
                            }
                            .foregroundColor(.white)
                        }
                        Spacer()
                        Text(self.getMonthHeader2())
                            .foregroundColor(.white)
                            .font(.system(size:20))
                            .frame(width: 170)
                            .padding(.horizontal,10)
                    }
                    Divider()
                    RKWeekdayHeader(rkManager: self.rkManager)
                    if isAnimation {
                        RKMonth(isPresented: self.$isPresented, rkManager: self.rkManager, monthOffset: self.monthOffset).transition(self.direction ? forward_transition : backward_transition)
                    }
                    else
                    {
                        RKMonth(isPresented: self.$isPresented, rkManager: self.rkManager, monthOffset: self.monthOffset).transition(self.direction ? forward_transition : backward_transition)
                    }
                    Spacer()
                }
                .padding(.top,10)
            }
            .padding(.horizontal,20)
            .frame(height: 320)
        }
    }
    
    func numberOfMonths() -> Int {
        return rkManager.calendar.dateComponents([.month], from: rkManager.minimumDate, to: RKMaximumDateMonthLastDay()).month! + 1
    }
    
    func RKMaximumDateMonthLastDay() -> Date {
        var components = rkManager.calendar.dateComponents([.year, .month, .day], from: rkManager.maximumDate)
        components.month! += 1
        components.day = 0
        
        return rkManager.calendar.date(from: components)!
    }
}

#if DEBUG
struct RKViewController_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            RKViewController(isPresented: .constant(false), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0))
            RKViewController(isPresented: .constant(false), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*32), mode: 0))
                .environment(\.colorScheme, .dark)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}
#endif

