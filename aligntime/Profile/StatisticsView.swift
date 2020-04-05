//
//  StatisticsView.swift
//  aligntime
//
//  Created by Ostap on 18/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct StatisticData {
    var date: String
    var minutes: Int
}

struct StatisticsView: View {
    @EnvironmentObject var core_data: AlignTime
    let calendar = Calendar.current
    @State private var hideHorizontalLines: Bool = false
    let hours:[Int] = [0,3,6,9,12,15,18,21,24]
    
    
    func test_date()->[Date]{
        var mydates:[Date] = []
        let fmt = DateFormatter()
        fmt.dateFormat = "yyy-MM-dd"
        var dateFrom =  Date() // First date
        var dateTo = Date()   // Last date
        dateFrom = core_data.minimumDate
        dateTo = core_data.maximumDate


        while dateFrom <= dateTo {
            mydates.append(dateFrom)
            dateFrom = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!

        }
        return mydates
    }
    
    func test_minutes()->[Int]{
        var mytime : [Int] = []
        let fmt = DateFormatter()
        fmt.dateFormat = "yyy-MM-dd"
        var dateFrom =  Date() // First date
        var dateTo = Date()   // Last date
        dateFrom = core_data.minimumDate
        dateTo = core_data.maximumDate

        while dateFrom <= dateTo {
            let val = self.core_data.total_wear_time_for_date(date:dateFrom)
            mytime.append(Int(val/60))
            dateFrom = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
        }
        return mytime
    }
    
    var body: some View {
        VStack{
            Text("Average hours per day: 21.5h")
            Divider()
            Text("Hours")
                .foregroundColor(Colors.LegendText)
                .font(.caption)
            HStack(){
                ForEach(hours, id: \.self) { width in
                    HStack(){
                        Spacer()
                        Text("\(width)")
                            .foregroundColor(Colors.LegendText)
                            .font(.caption)
                        Spacer()
                    }
                }
            }
            .padding(.leading, 55)
            ZStack{
                GeometryReader{ geometry in
                    Legend(data: ChartData(points: [1200,1000,500,700,750,0,0,150]),
                           frame: .constant(geometry.frame(in: .local)), hideHorizontalLines: self.$hideHorizontalLines,dates: self.test_date())
                        .transition(.opacity)
                        .animation(Animation.easeOut(duration: 1).delay(1))
                }
                .padding(.horizontal, 10)
                GeometryReader{ geometry in
                    Line(data: ChartData(points: [1200,1000,500,700,500,0,0,150]), frame: .constant(geometry.frame(in: .local)), touchLocation: .constant(CGPoint(x: 100, y: 12)), showIndicator: .constant(true), minDataValue: .constant(nil), maxDataValue: .constant(nil),showBackground: true)
                }
                .padding(.leading, 74)
            }
        }
    }
}
