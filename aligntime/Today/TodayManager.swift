//
//  Today.swift
//  aligntime
//
//  Created by Ostap on 27/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct TodayManager: View {
    @EnvironmentObject var user_data: AlignTime
    @State private var show_reminder = false
    
    var date_formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var today_date = Date()
    let generator_feedback = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Today: \(today_date, formatter: date_formatter)")
                .font(.system(size: 23))
                .foregroundColor(Color.primary)
                .fontWeight(Font.Weight.light)
            Spacer()
            VStack(alignment: .center) {
                HStack(alignment: .center, spacing: 4) {
                    Text("Wear time: ")
                        .font(.system(size: 24))
                        .foregroundColor(Color.primary)
                        .padding(.bottom, 5)
                    Text("\(self.user_data.wear_timer)")
                        .font(.system(size: 24))
                        .foregroundColor(Color.blue)
                        .padding(.bottom, 5)
                }
                HStack(alignment: .center, spacing: 0) {
                    Text("Out time: ")
                        .font(.system(size: 24))
                        .foregroundColor(Color.primary)
                    Text("\(self.user_data.out_timer)")
                        .font(.system(size: 24))
                        .foregroundColor(Color.blue)
                }
            }
            .padding(.bottom, 10)
            Button(action: {
                if !self.user_data.play_state{
                    self.user_data.start_wear()
                    self.user_data.play_state = !self.user_data.play_state
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
                    Image(systemName: self.user_data.play_state ? "pause.circle" : "play.circle" )
                        .font(.system(size: 90))
                }
            }
            .frame(width: 120, height: 120, alignment: .bottom)
            .actionSheet(isPresented: $show_reminder) {
                ActionSheet(title: Text("Reminder"),
                            message: Text("You will receive notification in the time interval they’ve selected"),
                            buttons: [.default(Text("10 Seconds (for debug)"),action: {
                                        self.user_data.out_wear()
                                        self.user_data.play_state = !self.user_data.play_state
                                        self.user_data.send_notification(time_interval: 10)
                                        }),
                                      .default(Text("15 Minutes"), action: {
                                        self.user_data.out_wear()
                                        self.user_data.play_state = !self.user_data.play_state
                                        self.user_data.send_notification(time_interval: 900)
                                      }),
                                      .default(Text("30 Minutes"), action: {
                                        self.user_data.out_wear()
                                        self.user_data.play_state = !self.user_data.play_state
                                        self.user_data.send_notification(time_interval: 1800)
                                      }),
                                      .default(Text("1 Hour"), action: {
                                        self.user_data.out_wear()
                                        self.user_data.play_state = !self.user_data.play_state
                                        self.user_data.send_notification(time_interval: 3600)
                                      }),
                                      .cancel(),
                                               
                ])
            }
//            .alert(isPresented: $isShowingAlert) {
//                Alert(title: Text("Delete book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("20"))
//                {
//                        print("asd")
//                    }, secondaryButton:.destructive(Text("10")){
//                        print("asd2")
//                    }
//                )
//            }
            Spacer()
            HStack(alignment: .center, spacing: 4) {
                Text("You have been wearing aligners for")
                    .font(.system(size: 17))
                    .foregroundColor(Color.primary)
                Text(self.user_data.wearing_aligners_days)
                    .font(.system(size: 20))
                    .foregroundColor(Color.blue)
                Text("days")
                    .font(.system(size: 17))
                    .foregroundColor(Color.primary)
            }
            HStack(alignment: .center, spacing: 4) {
                Text(self.user_data.days_left)
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
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.user_data.complete = true
                self.user_data.push_user_defaults()
            })
        }
    }
}
