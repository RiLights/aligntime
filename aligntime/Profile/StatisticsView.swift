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
    
    var date_formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func get_dates()->[Date]{
        let dates = self.test_date()
        var res:[Date] = []
        res.append(dates.first)
        let count:Double = Double(dates.count)
        let val = count/8
        for i in stride(from: 1, to: count, by: val) {
            res.append(dates[Int(i)])
        }
        res.append(dates.last)
        return res
    }
    
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
    
    func test_minutes()->[Double]{
        var mytime : [Double] = []
        let fmt = DateFormatter()
        fmt.dateFormat = "yyy-MM-dd"
        var dateFrom =  Date() // First date
        var dateTo = Date()   // Last date
        dateFrom = core_data.minimumDate
        dateTo = core_data.maximumDate

        while dateFrom <= dateTo {
            let val = self.core_data.total_wear_time_for_date(date:dateFrom)
            mytime.append(Double(val/60))
            dateFrom = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
        }
        return mytime
    }
    
    func test_average()->Int{
        let intArray = test_minutes()
        let sumArray = intArray.reduce(0, +)

        let avgArrayValue = sumArray/Double(intArray.count)
        
        return Int(avgArrayValue/60)
    }
    
    var body: some View {
        VStack{
            if self.test_date().count<2{
                Text(NSLocalizedString("Not enough data for statistic",comment:""))
                    .foregroundColor(Colors.LegendText)
            }
            else{
                Group{
                    HStack{
                        Text(NSLocalizedString("Average wear time: ",comment:""))
                            + Text("\(test_average())")
                                .foregroundColor(.blue)
                            + Text(NSLocalizedString("per_hour",comment:""))
                        Spacer()
                    }
                    .padding()
                }
                .font(.system(size: 16))
                Divider()
                Text(NSLocalizedString("Hours",comment:""))
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
                .padding(.leading, 60)
                ZStack{
                    VStack(spacing:0){
                        ForEach(get_dates(), id: \.self) { d in
                            Group {
                                HStack{
                                    Text("\(d, formatter: self.date_formatter)")
                                        .foregroundColor(Colors.LegendText)
                                        .font(.caption)
                                    VStack(spacing:0){
                                        Divider()
                                    }
                                }
                                if d != self.get_dates().last{
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    GeometryReader{ geometry in
                        Line(data: self.test_minutes(), frame: .constant(geometry.frame(in: .local)), touchLocation: .constant(CGPoint(x: 100, y: 12)), showIndicator: .constant(true),showBackground: true)
                    }
                    .padding(.leading, 78)
                }
            }
        }
        .navigationBarTitle(Text(NSLocalizedString("Time Statistic",comment:"")), displayMode: .large)
    }
}
