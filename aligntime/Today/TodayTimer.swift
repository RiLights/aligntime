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
    @State var show_reminder = false
    @State var out_hours:Bool = false
    let generator_feedback = UIImpactFeedbackGenerator(style: .light)
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func start_timer(){
        self.core_data.current_state = true
        self.core_data.switch_timer()
        self.core_data.remove_wear_notification()
    }
    func pause_timer(time_interval:Double){
        self.core_data.current_state = false
        self.core_data.switch_timer()
        if time_interval != 0 {
            self.core_data.send_wear_notification(time_interval: time_interval)
        }
    }
    
    var body: some View {
        VStack{
            VStack(alignment: .center) {
                HStack(alignment: .center, spacing: 4) {
                    Text(NSLocalizedString("Wear time: ",comment:""))
                        .foregroundColor(Color.primary)
                        .padding(.bottom, 5)
                    Text(wear_time)
                        .foregroundColor(Color.blue)
                        .padding(.bottom, 5)
                }
                HStack(alignment: .center, spacing: 0) {
                    Text(NSLocalizedString("Out time: ",comment:""))
                        .foregroundColor(Color.primary)
                    Text(off_time)
                        .foregroundColor(self.out_hours ? Color.orange : Color.accentColor)
                }
            }
            .padding(.bottom, 10)
            .font(.title)
            .onReceive(self.timer) { input in
                self.wear_time = timer_format(self.core_data.get_wear_timer_for_date(update_time: input))!
                self.off_time = timer_format(self.core_data.get_off_timer_for_date(update_time: input))!
                self.out_hours = Int(self.core_data.get_off_timer_for_date(update_time: input)/60)>Int((24-self.core_data.wear_hours)*60)
                
                // Need to update after night for change aligner state
                if self.wear_time == "00:00:01"{
                    self.core_data.update_today_dates()
                }
            }
            .onAppear() {
                self.wear_time = timer_format(self.core_data.get_wear_timer_for_date(update_time: Date()))!
                self.off_time = timer_format(self.core_data.get_off_timer_for_date(update_time: Date()))!
                self.out_hours = Int(self.core_data.get_off_timer_for_date(update_time: Date())/60)>Int((24-self.core_data.wear_hours)*60)
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
                        .foregroundColor(self.core_data.current_state ? Color.accentColor : Color.orange)
                }
            }
            .frame(width: 120, height: 120, alignment: .bottom)
        }
        .actionSheet(isPresented: $show_reminder) {
            ActionSheet(title: Text(NSLocalizedString("Wear Time Reminder",comment:"")),
                        message: Text(NSLocalizedString("Remind me to wear aligners again in",comment:"")),
                        buttons: [
                                  .default(Text(NSLocalizedString("15 Minutes",comment:"")), action: {
                                    self.pause_timer(time_interval: 900)
                                  }),
                                  .default(Text(NSLocalizedString("30 Minutes",comment:"")), action: {
                                        self.pause_timer(time_interval: 1800)
                                  }),
                                  .default(Text(NSLocalizedString("1 Hour",comment:"")), action: {
                                        self.pause_timer(time_interval: 3600)
                                  }),
                                  .default(Text(NSLocalizedString("No Reminder",comment:"")),action: {
                                      self.pause_timer(time_interval: 0)
                                  }),
                                  .cancel(),
            ])
        }
    }
}
