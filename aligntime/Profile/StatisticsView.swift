//
//  StatisticsView.swift
//  aligntime
//
//  Created by Ostap on 18/02/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct StatisticsView: View {
    var body: some View {
        VStack{
            LineChartView(data: [80,23,54,32,12,37,7,23,43], title: "Test",rateValue:0,dropShadow:false)
        }
    }
}
