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
        VStack{
            HStack(alignment: .center, spacing: 4) {
                if self.core_data.wearing_aligners_days >= 1 {
                    Text(NSLocalizedString("You_have_been_wearing_aligners_for",comment:""))
                        .font(.system(size: 17))
                        .foregroundColor(Color.primary)
                    Text("\(self.core_data.wearing_aligners_days)")
                        .font(.system(size: 20))
                        .foregroundColor(Color.blue)
                }
                else{
                    Text(NSLocalizedString("You have just started your treatment",comment:""))
                        .font(.system(size: 17))
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
                Text(NSLocalizedString("days_left_until_the_end_of_your_treatment",comment:""))
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

