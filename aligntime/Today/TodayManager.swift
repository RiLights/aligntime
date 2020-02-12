//
//  Today.swift
//  aligntime
//
//  Created by Ostap on 27/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

func timer_format(_ second: TimeInterval) -> String? {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.zeroFormattingBehavior = .pad
    return formatter.string(from: second)
}

struct TodayManager: View {
    @EnvironmentObject var core_data: AlignTime
    @State private var show_reminder = false
    @State var currentDate = Date()
    @State var wear_time = "00:00:00"
    @State var off_time = "00:00:00"
    //@Binding var timer:Int
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var date_formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    var date_formatter_time: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
    
    var today_date = Date()
    @State var last_date:Date = Date()
    let generator_feedback = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Today:")
                    .font(.system(size: 23))
                    .foregroundColor(Color.primary)
                    .fontWeight(Font.Weight.light)
                Text("\(today_date, formatter: date_formatter)")
                    .font(.system(size: 23))
                    .foregroundColor(Color.accentColor)
                    .fontWeight(Font.Weight.light)
            }
            
            Spacer()
            VStack(alignment: .center) {
                HStack(alignment: .center, spacing: 4) {
                    Text("Wear time: ")
                        .font(.system(size: 24))
                        .foregroundColor(Color.primary)
                        .padding(.bottom, 5)
                    Text(wear_time)
                        .font(.system(size: 24))
                        .foregroundColor(Color.blue)
                        .padding(.bottom, 5)
                }
                HStack(alignment: .center, spacing: 0) {
                    Text("Out time: ")
                        .font(.system(size: 24))
                        .foregroundColor(Color.primary)
                    Text(off_time)
                        .font(.system(size: 24))
                        .foregroundColor(Color.blue)
                }
            }
            .padding(.bottom, 10)
            .onReceive(self.timer) { input in
                if self.core_data.current_state{
                    self.wear_time = timer_format(self.core_data.get_wear_timer_for_date(update_time: input))!
                }
                else {
                    self.off_time = timer_format(self.core_data.get_off_timer_for_date(update_time: Date()))!
                }
            }
            .onAppear() {
                if self.core_data.current_state{
                    self.wear_time = timer_format(self.core_data.get_wear_timer_for_date(update_time: Date()))!
                    self.off_time = timer_format(self.core_data.get_off_timer_for_date(update_time: Date()))!
                }
                else {
                    self.wear_time = timer_format(self.core_data.get_wear_timer_for_date(update_time: Date()))!
                    self.off_time = timer_format(self.core_data.get_off_timer_for_date(update_time: Date()))!
                }
            }
            Button(action: {
                if !self.core_data.play_state{
                    self.core_data.current_state = !self.core_data.current_state
                    self.core_data.play_state = !self.core_data.play_state
                    self.core_data.switch_timer()
                }
                else{
                    self.show_reminder.toggle()
                }
                                
                //haptic feedback
                self.generator_feedback.impactOccurred()
            }){
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.primary, lineWidth: 2)
                    Image(systemName: self.core_data.play_state ? "pause.circle" : "play.circle" )
                        .font(.system(size: 90))
                }
            }
            .frame(width: 120, height: 120, alignment: .bottom)
            .actionSheet(isPresented: $show_reminder) {
                ActionSheet(title: Text("Reminder"),
                            message: Text("You will receive notification in the time interval they’ve selected"),
                            buttons: [.default(Text("10 Seconds (for debug)"),action: {
                                        self.core_data.current_state = !self.core_data.current_state
                                        self.core_data.play_state = !self.core_data.play_state
                                        self.core_data.switch_timer()
                                        self.core_data.send_notification(time_interval: 10)
                                        }),
                                      .default(Text("15 Minutes"), action: {
                                        self.core_data.current_state = !self.core_data.current_state
                                        self.core_data.play_state = !self.core_data.play_state
                                        self.core_data.switch_timer()
                                        self.core_data.send_notification(time_interval: 900)
                                      }),
                                      .default(Text("30 Minutes"), action: {
                                        self.core_data.current_state = !self.core_data.current_state
                                        self.core_data.play_state = !self.core_data.play_state
                                        self.core_data.switch_timer()
                                        self.core_data.send_notification(time_interval: 1800)
                                      }),
                                      .default(Text("1 Hour"), action: {
                                        self.core_data.current_state = !self.core_data.current_state
                                        self.core_data.play_state = !self.core_data.play_state
                                        self.core_data.switch_timer()
                                        self.core_data.send_notification(time_interval: 3600)
                                      }),
                                      .cancel(),
                ])
            }
            Spacer()
            HStack(alignment: .center, spacing: 4) {
                Text("You have been wearing aligners for")
                    .font(.system(size: 17))
                    .foregroundColor(Color.primary)
                Text(self.core_data.wearing_aligners_days)
                    .font(.system(size: 20))
                    .foregroundColor(Color.blue)
                Text("days")
                    .font(.system(size: 17))
                    .foregroundColor(Color.primary)
            }
            HStack(alignment: .center, spacing: 4) {
                Text(self.core_data.days_left)
                    .font(.system(size: 20))
                    .foregroundColor(Color.blue)
                    .padding(.leading, 5)
                    .padding(.top, 7)
                    .padding(.bottom, 30)
                Text("days left until the end of your treatment")
                    .font(.system(size: 17))
                    .foregroundColor(Color.primary)
                    .padding(.trailing, 5)
                    .padding(.top, 7)
                    .padding(.bottom, 30)
            }
        }
        .onAppear() {
            self.core_data.update_today_dates()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.core_data.complete = true
                self.core_data.push_user_defaults()
            })
        }
    }
}
