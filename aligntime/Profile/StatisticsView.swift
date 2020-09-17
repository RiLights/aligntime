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
    
    func get_total_wear_time_for_past(day_index:Int)->CGFloat{
        let date_offset = Calendar.current.date(byAdding: .day, value: -day_index, to: Date())
        let wear_time = self.core_data.total_wear_time_for_date(date:date_offset!)
        return CGFloat(wear_time.hours)
    }
    
    func get_day_for_past(day_index:Int)->String{
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd"
        //dateFormatterPrint.dateStyle = .short
        
        let date_offset = Calendar.current.date(byAdding: .day, value: -day_index, to: Date())
        return dateFormatterPrint.string(from: date_offset!)
    }
    
    func get_month_for_past(day_index:Int)->String{
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM"
        //dateFormatterPrint.dateStyle = .short
        
        let date_offset = Calendar.current.date(byAdding: .day, value: -day_index, to: Date())
        return dateFormatterPrint.string(from: date_offset!)
    }
    
    var stat_range = ["7", "30"]
    @State private var selected_stat_range = 0
    
    var body: some View {
        VStack{
            Picker(selection: self.$selected_stat_range, label: Text("hello")) {
                ForEach((0...1), id: \.self) { i in
                    Text("\(self.stat_range[i]) ")
                    + Text(NSLocalizedString("days",comment:""))
                }
            }.pickerStyle(SegmentedPickerStyle())
            VStack{
                HStack{
                    Spacer()
                    Text(NSLocalizedString("Average wear time: ",comment:""))
                        + Text("\(test_average())")
                            .foregroundColor(.blue)
                        + Text(NSLocalizedString("per_hour",comment:""))
                    Spacer()
                }
                HStack(spacing:0){
                    VStack{
                        Text(NSLocalizedString("Hours",comment:""))
                        .padding(.vertical,4)
                        Text("24")
                        .padding(.vertical,4)
                        Group{
                            ForEach(stride(from: 0, to: 24, by: 4).reversed(), id: \.self) { i in
                                Text("\(i)")
                                    .padding(.vertical,4)
                            }
                        }
                        Spacer()
                    }.padding(.leading,20)
                    Spacer()
                    if self.selected_stat_range == 0{
                        ForEach((1...7).reversed(), id: \.self) { i in
                            VStack{
                                Spacer()
                                RoundedRectangle(cornerRadius: 3)
                                    .foregroundColor(.accentColor)
                                    .frame(width: 10, height: self.get_total_wear_time_for_past(day_index:i)*6)
                                    .padding(.horizontal,15)
                                    Text("\(self.get_day_for_past(day_index:i))")
                                    Text("\(self.get_month_for_past(day_index:i))")
                            }
                        }
                    }
                    else if self.selected_stat_range == 1 {
                        VStack{
                            HStack(spacing:0){
                                ForEach((1...30).reversed(), id: \.self) { i in
                                    VStack{
                                        Spacer()
                                        RoundedRectangle(cornerRadius: 2)
                                            .foregroundColor(.accentColor)
                                            .frame(width: 7, height: self.get_total_wear_time_for_past(day_index:i)*6)
                                            .padding(.horizontal,1)
                                            //Text("\(self.get_day_for_past(day_index:i))")
                                            //Text("\(self.get_month_for_past(day_index:i))")
                                    }
                                }
                            }
                            HStack{
                                VStack{
                                    Text("\(self.get_day_for_past(day_index:30))")
                                    Text("\(self.get_month_for_past(day_index:30))")
                                }
                                .padding(.leading,20)
                                Spacer()
                                Text("...")
                                Spacer()
                                VStack{
                                    Text("\(self.get_day_for_past(day_index:1))")
                                    Text("\(self.get_month_for_past(day_index:1))")
                                }.padding(.trailing,20)
                            }
                        }
                    }
                    Spacer()
                }
                .font(.footnote)
                .foregroundColor(.gray)
                .frame(height: 210)
                .padding(.vertical,10)
                .transition(.identity)
                .animation(.easeIn(duration: 0.15))
                Divider()
                Spacer()
            }
            
//            GeometryReader{ geometry in
//                Line(data: self.test_minutes(), frame: .constant(geometry.frame(in: .local)), touchLocation: .constant(CGPoint(x: 100, y: 12)), showIndicator: .constant(true),showBackground: true)
//            }
//            .padding(.leading, 78)
//            HStack{
//                Text(NSLocalizedString("Average wear time: ",comment:""))
//                    + Text("\(test_average())")
//                        .foregroundColor(.blue)
//                    + Text(NSLocalizedString("per_hour",comment:""))
//                Spacer()
//            }
//            .padding()
//            .font(.system(size: 16))
        }
        .navigationBarTitle(Text(NSLocalizedString("Time Statistic",comment:"")), displayMode: .large)
    }
}
