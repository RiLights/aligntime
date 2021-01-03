//
//  TodayDaysLeft.swift
//  aligntime
//
//  Created by Ostap on 12/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct TodayDaysLeft: View {
    @EnvironmentObject var core_data: AlignTime
    
    func is_plural_number()->Bool{
        if self.core_data.wearing_aligners_days.description.last! == "2"{
            return true
        }
        else if self.core_data.wearing_aligners_days.description.last! == "3"{
            return true
        }
        else if self.core_data.wearing_aligners_days.description.last! == "4"{
            return true
        }
        return false
    }
    
    var body: some View {
        VStack(){
//            LeftDaysVisualisation()
//            Group{
//                Text("450")
//                    .font(.body)
//                    .foregroundColor(.accentColor)
//                + Text(" Days Total")
//                    .font(.body)
//            }
//            .padding(.bottom,20)
            HStack(alignment: .center, spacing: 4) {
                if self.core_data.wearing_aligners_days >= 1 {
                    Text(NSLocalizedString("You_have_been_wearing_aligners_for",comment:""))
                        .foregroundColor(Color.primary)
                    Text("\(self.core_data.wearing_aligners_days)")
                        .scaledFont(size: 20)
                        //.font(.headline)
                        //.font(.title)
                        //.bold()
                        .foregroundColor(Color.blue)
                }
                else{
                    Text(NSLocalizedString("You have just started your treatment",comment:""))
                        .foregroundColor(Color.primary)
                }
                Group{
                    if self.core_data.wearing_aligners_days == 1 {
                        Text(NSLocalizedString("day",comment:""))
                    }
                    else if self.is_plural_number(){
                        Text(NSLocalizedString("days/4",comment:""))
                    }
                    else if self.core_data.wearing_aligners_days == 0{
                        Text("")
                    }
                    else{
                        Text(NSLocalizedString("days",comment:""))
                    }
                }
                    //.font(.system(size: 17))
                    .foregroundColor(Color.primary)

            }
            .font(.body)
            HStack(alignment: .center, spacing: 4) {
                if self.core_data.days_left != "0"{
                    if Locale.preferredLanguages[0].prefix(2) == "zh"{
                        Text(NSLocalizedString("days_left_until_the_end_of_your_treatment",comment:""))
                            //.font(.system(size: 17))
                            .foregroundColor(Color.primary)
                            //.padding(.trailing, 5)
                        Text(self.core_data.days_left)
                            .scaledFont(size: 20)
                            //.bold()
                            .foregroundColor(Color.blue)
                        Text(NSLocalizedString("天",comment:""))
                            //.font(.system(size: 17))
                            .foregroundColor(Color.primary)
                    }
                    else{
                        Text(self.core_data.days_left)
                            .scaledFont(size: 20)
                            //.bold()
                            .foregroundColor(Color.blue)
                        Text(NSLocalizedString("days_left_until_the_end_of_your_treatment",comment:""))
                            //.font(.system(size: 17))
                            .foregroundColor(Color.primary)
                            //.padding(.trailing, 5)
                    }
                }
                else{
                    Text(NSLocalizedString("congratulations",comment:""))
                        .foregroundColor(Color.primary)
                }
            }
            .padding(.top, 7)
            .padding(.bottom, 30)
            .font(.body)
        }
        .onAppear() {
            self.core_data.update_today_dates()
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: {
                self.core_data.complete = true
                self.core_data.push_user_defaults()
            })
        }
    }
}


struct LeftDaysVisualisation: View {
    @EnvironmentObject var core_data: AlignTime

    var date_formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

    var body: some View {
        VStack(spacing:0){
            Text("201")
                .foregroundColor(.blue)
                .padding(.leading,21)
                .font(.body)
            Image(systemName:"chevron.down")
                .font(.system(size: 12))
                .foregroundColor(.blue)
                .padding(4)
                .padding(.leading,21)
            ZStack{
                RoundedRectangle(cornerRadius: 2)
                    .foregroundColor(.gray)
                HStack(spacing:0) {
                    ForEach(0...80, id: \.self) { width in
                        HStack(spacing:0) {
                            Rectangle()
                                .frame(width:2)
                                .foregroundColor(.accentColor)
                        }
                    }
                    Spacer()
                }
            }
            .frame(width: 300, height: 8)
        }
    }
}
