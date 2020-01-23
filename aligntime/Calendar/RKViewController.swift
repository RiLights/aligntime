//
//  RKViewController.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//
import SwiftUI


struct RKViewController: View {
    
    @State private var mounthOffset = 0
    @Binding var isPresented: Bool
    @State private var isAnimation = false
    @State private var eege = Edge.trailing
    @State var direction:Bool = true
    
    @ObservedObject var rkManager: RKManager
    
    var body: some View {
        Group() {
            ZStack(alignment: .top){
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.accentColor)
                VStack {
                    HStack {
                        Button("<") {
                            self.mounthOffset -= 1;
                            //forward_transition.combined(with: backward_transition)
                            //self.transition = forward_transition
                            //self.eege = Edge.leading
                            self.direction = false
                            withAnimation {
                                self.isAnimation.toggle()
                            }
                        }
                        .foregroundColor(.white)
                        //.padding(.trailing,5)
                        Button(">") {
                            self.mounthOffset += 1;
                            //transition = backward_transition
                            //self.eege = Edge.trailing
                            self.direction = true
                            withAnimation {
                                self.isAnimation.toggle()
                            }
                        }
                        .foregroundColor(.white)
                    }
                    Divider()
                    RKWeekdayHeader(rkManager: self.rkManager)
                    if isAnimation {
                        RKMonth(isPresented: self.$isPresented, rkManager: self.rkManager, monthOffset: self.mounthOffset).transition(self.direction ? forward_transition : backward_transition)
                    }
                    else
                    {
                        RKMonth(isPresented: self.$isPresented, rkManager: self.rkManager, monthOffset: self.mounthOffset).transition(self.direction ? forward_transition : backward_transition)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal,20)
            .frame(height: 350)
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

