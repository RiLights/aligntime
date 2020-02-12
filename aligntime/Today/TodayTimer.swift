//
//  TodayTimer.swift
//  aligntime
//
//  Created by Ostap on 12/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct TodayTimer: View {
    @EnvironmentObject var core_data: AlignTime
    @State var wear_time = "00:00:00"
    @State var off_time = "00:00:00"
    @State private var show_reminder = false
    let generator_feedback = UIImpactFeedbackGenerator(style: .light)
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func start_timer(){
        self.core_data.current_state = true
        self.core_data.switch_timer()
        self.core_data.remove_notification()
    }
    func pause_timer(time_interval:Double){
        self.core_data.current_state = false
        self.core_data.switch_timer()
        self.core_data.send_notification(time_interval: time_interval)
    }
    
    var body: some View {
        VStack{
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
                    self.off_time = timer_format(self.core_data.get_off_timer_for_date(update_time: input))!
                }
            }
            .onAppear() {
                print("apear")
                self.wear_time = timer_format(self.core_data.get_wear_timer_for_date(update_time: Date()))!
                self.off_time = timer_format(self.core_data.get_off_timer_for_date(update_time: Date()))!
            }
            Button(action: {
                if !self.core_data.current_state{
                    self.start_timer()
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
                    Image(systemName: self.core_data.current_state ? "pause.circle" : "play.circle" )
                        .font(.system(size: 90))
                }
            }
            .frame(width: 120, height: 120, alignment: .bottom)
        }
        .actionSheet(isPresented: $show_reminder) {
            ActionSheet(title: Text("Reminder"),
                        message: Text("You will receive notification in the time interval they’ve selected"),
                        buttons: [.default(Text("10 Seconds (for debug)"),action: {
                                        self.pause_timer(time_interval: 10)
                                    }),
                                  .default(Text("15 Minutes"), action: {
                                        self.pause_timer(time_interval: 900)
                                  }),
                                  .default(Text("30 Minutes"), action: {
                                        self.pause_timer(time_interval: 1800)
                                  }),
                                  .default(Text("1 Hour"), action: {
                                        self.pause_timer(time_interval: 3600)
                                  }),
                                  .cancel(),
            ])
        }
    }
}
