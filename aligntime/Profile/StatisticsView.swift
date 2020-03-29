//
//  StatisticsView.swift
//  aligntime
//
//  Created by Ostap on 18/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var core_data: AlignTime
    
    var body: some View {
        VStack{
            Text("ChartView")
            ForEach(core_data.intervals) { i in
                Text("\(i.time_string )")
                
            }
            Text("Debug Value \(core_data.selected_month)")
            //LineChartView(data: [80,23,54,32,12,37,7,23,43], title: "Test",rateValue:0,dropShadow:false)
        }
    }
}
