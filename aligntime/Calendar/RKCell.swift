//
//  RKCell.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import SwiftUI

struct RKCell: View {
    
    @EnvironmentObject var core_data: AlignTime
    var rkDate: RKDate
    
    var cellWidth: CGFloat
    
    var body: some View {
        Text(rkDate.getText())
            .fontWeight(rkDate.getFontWeight())
            .foregroundColor(rkDate.getTextColor())
            .frame(width: cellWidth, height: cellWidth)
            .font(.system(size: 18))
            .background(rkDate.getBackgroundColor())
            .cornerRadius(cellWidth/2)
            .onTapGesture(count: 1) { // TODO: Figure out why picked self.rkDate.date less by one day than has to be
                let fix_rkdate_value = Calendar.current.date(byAdding: .day, value: 1, to: self.rkDate.date)!
                self.core_data.selected_date = fix_rkdate_value
                }
    }
}


