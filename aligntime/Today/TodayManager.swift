//
//  Today.swift
//  aligntime
//
//  Created by Ostap on 27/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct TodayManager: View {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    var today_date = Date()
    @State var play_state:Bool = false
    var body: some View {
        VStack(alignment: .center) {
            Text("Today,: \(today_date, formatter: dateFormatter)")
                .font(.headline)
                .foregroundColor(Color.primary)
            Spacer()
            VStack(alignment: .center) {
                Text("Wear time: 2")
                    .font(.headline)
                    .foregroundColor(Color.primary)
                    .padding(.vertical, 5)
                Text("Our time: 3")
                    .font(.headline)
                    .foregroundColor(Color.primary)
            }
            .padding(.vertical, 10)
            Button(action: {
                self.play_state = !self.play_state
            }){
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.primary, lineWidth: 2)
                    Image(systemName: self.play_state ? "play.circle" : "pause.circle")
                        .font(.system(size: 80))
                        
                }
            }
            .frame(width: 110, height: 110, alignment: .bottom)
            Spacer()
            HStack(alignment: .center, spacing: 4) {
                Text("You are wearing Aligner")
                    .font(.headline)
                    .foregroundColor(Color.primary)
                    .padding(.leading, 10)
                Text("3")
                    .font(.headline)
                    .foregroundColor(Color.blue)
                Text("days")
                    .font(.headline)
                    .foregroundColor(Color.primary)
                    .padding(.trailing, 10)
            }
            HStack(alignment: .center, spacing: 4) {
                Text("70")
                    .font(.headline)
                    .foregroundColor(Color.blue)
                    .padding(.leading, 5)
                    .padding(.bottom, 30)
                Text("of days till the end of the treatment")
                    .font(.headline)
                    .foregroundColor(Color.primary)
                    .padding(.trailing, 5)
                    .padding(.bottom, 30)
            }
        }
    }
}

