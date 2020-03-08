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
    var rim_color: Color = Color.clear
    
    var body: some View {
        Text(rkDate.getText())
            .fontWeight(rkDate.getFontWeight())
            .foregroundColor(rkDate.getTextColor())
            .frame(width: cellWidth, height: cellWidth)
            .font(.system(size: 18))
            .background(rkDate.getBackgroundColor())
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(rim_color, lineWidth: 2)
            )
            .cornerRadius(cellWidth/2)
            
    }
}


