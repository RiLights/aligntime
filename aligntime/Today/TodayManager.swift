//
//  Today.swift
//  aligntime
//
//  Created by Ostap on 27/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct TodayManager: View {
    @EnvironmentObject var user_data: UserData
    
    var date_formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var today_date = Date()
    
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
                    Text("\(self.user_data.timer)")
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
                self.user_data.play_state = !self.user_data.play_state
                if self.user_data.play_state{
                    if self.user_data.start_time == nil{
                        self.user_data.start_time = Date()
                    }
                    else{
                        self.user_data.start_time = Date().addingTimeInterval((self.user_data.elapsed_time)*(-1))
                    }
                }
                else{
                    self.user_data.out_time = Date().addingTimeInterval((self.user_data.out_elapsed_time)*(-1))
                }
            }){
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.primary, lineWidth: 2)
                    Image(systemName: self.user_data.play_state ? "pause.circle" : "play.circle" )
                        .font(.system(size: 90))
                }
            }
            .frame(width: 120, height: 120, alignment: .bottom)
            Spacer()
            HStack(alignment: .center, spacing: 4) {
                Text("You have been wearing aligners for")
                    .font(.system(size: 17))
                    .foregroundColor(Color.primary)
                Text("3")
                    .font(.system(size: 20))
                    .foregroundColor(Color.blue)
                Text("days")
                    .font(.system(size: 17))
                    .foregroundColor(Color.primary)
            }
            HStack(alignment: .center, spacing: 4) {
                Text("70")
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

