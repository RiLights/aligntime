//
//  StatisticsView.swift
//  aligntime
//
//  Created by Ostap on 18/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct CustomShape: Shape {
    @State var value_list:[Int] = []
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        for (i,v) in value_list.enumerated(){
            //path.addLine(to: CGPoint(x: v/3, y: (i+1)*17))
            path.addQuadCurve(to: CGPoint(x: v/3, y: (i+1)*17), control: CGPoint(x: v/4, y: (i+1)*18))
            //path.addCurve(to: CGPoint(x: v/3, y: (i+1)*17), control1: CGPoint(x: v/4, y: (i+1)*17), control2: CGPoint(x: v/4, y: (i+1)*17))
        }
        path.addLine(to: CGPoint(x: 0, y: value_list.endIndex * 18))
        return path
    }
}


struct StatisticsView: View {
    @EnvironmentObject var core_data: AlignTime
    let calendar = Calendar.current
    var path = Path()
    
    
    func test()->[String]{
        var mydates : [String] = []
        let fmt = DateFormatter()
        fmt.dateFormat = "yyy-MM-dd"
        var dateFrom =  Date() // First date
        var dateTo = Date()   // Last date
        dateFrom = core_data.minimumDate
        dateTo = core_data.maximumDate


        while dateFrom <= dateTo {
            mydates.append(fmt.string(from: dateFrom))
            dateFrom = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!

        }
        return mydates
    }
    
    func test_list()->[Int]{
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
        VStack(spacing:0){
            Text("ChartView")
            ScrollView(.vertical) {
                ZStack{
                    CustomShape(value_list:test_list())
                        .stroke(lineWidth: 1)
                        .fill(Color.orange)
                    VStack(spacing:0){
                        ForEach(0...20, id: \.self) { i in
                                HStack{
                                    Text("\(self.test()[i])")
                                        .font(.system(size: 14.6))
                                    Divider()
                                    Spacer()
                                    Text("\(self.test_list()[i])")
                                        .font(.system(size: 14.6))
            //                    Path { path in
            //                         path.move(to: CGPoint(x: i, y: 0))
            //                         path.addLine(to: CGPoint(x: i*2, y: 10))
            //                     }.stroke(lineWidth: 2)
                                }
                            //}
                        }
                    }
                }
//                ForEach(test(),id: \.self) { i in
//                    HStack{
//                        Text("\(i)")
//                        Text("\(hour_timer_format(self.core_data.total_wear_time_for_date(date:self.core_data.selected_date))!)")
//                        SpiroSquare()
//                            .stroke()
//                            .frame(width: 200, height: 200)
//                    }
//                }

            }
            //Text("Debug Value \(test())")
            //LineChartView(data: [80,23,54,32,12,37,7,23,43], title: "Test",rateValue:0,dropShadow:false)
        }
    }
}

struct HexagonParameters {
    struct Segment {
        let useWidth: (CGFloat, CGFloat, CGFloat)
        let xFactors: (CGFloat, CGFloat, CGFloat)
        let useHeight: (CGFloat, CGFloat, CGFloat)
        let yFactors: (CGFloat, CGFloat, CGFloat)
    }
    
    static let adjustment: CGFloat = 0.085
    
    static let points = [
        Segment(
            useWidth:  (1.00, 1.00, 1.00),
            xFactors:  (0.60, 0.40, 0.50),
            useHeight: (1.00, 1.00, 0.00),
            yFactors:  (0.05, 0.05, 0.00)
        ),
        Segment(
            useWidth:  (1.00, 1.00, 0.00),
            xFactors:  (0.05, 0.00, 0.00),
            useHeight: (1.00, 1.00, 1.00),
            yFactors:  (0.20 + adjustment, 0.30 + adjustment, 0.25 + adjustment)
        ),
        Segment(
            useWidth:  (1.00, 1.00, 0.00),
            xFactors:  (0.00, 0.05, 0.00),
            useHeight: (1.00, 1.00, 1.00),
            yFactors:  (0.70 - adjustment, 0.80 - adjustment, 0.75 - adjustment)
        ),
        Segment(
            useWidth:  (1.00, 1.00, 1.00),
            xFactors:  (0.40, 0.60, 0.50),
            useHeight: (1.00, 1.00, 1.00),
            yFactors:  (0.95, 0.95, 1.00)
        ),
        Segment(
            useWidth:  (1.00, 1.00, 1.00),
            xFactors:  (0.95, 1.00, 1.00),
            useHeight: (1.00, 1.00, 1.00),
            yFactors:  (0.80 - adjustment, 0.70 - adjustment, 0.75 - adjustment)
        ),
        Segment(
            useWidth:  (1.00, 1.00, 1.00),
            xFactors:  (1.00, 0.95, 1.00),
            useHeight: (1.00, 1.00, 1.00),
            yFactors:  (0.30 + adjustment, 0.20 + adjustment, 0.25 + adjustment)
        )
    ]
}
