//
//  Line.swift
//  LineChart
//
//  Created by András Samu on 2019. 08. 30..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct Line: View {
    var data: [Double]
    @Binding var frame: CGRect
    @Binding var touchLocation: CGPoint
    @Binding var showIndicator: Bool
    var minDataValue: Int = 0
    var maxDataValue: Int = 1440
    @State private var showFull: Bool = false
    @State var showBackground: Bool = true
    var gradient: GradientColor = GradientColor(start: Colors.GradientPurple, end: Colors.GradientNeonBlue)
    var index:Int = 0
    let padding:CGFloat = 18
    var curvedLines: Bool = true
    var stepWidth: CGFloat {
        return (frame.size.width-padding) / CGFloat(maxDataValue + minDataValue)

    }
    var stepHeight: CGFloat {
        if data.count < 2 {
            return 0
        }
        return frame.size.height / CGFloat(data.count-1)
    }
    var path: Path {
        let points = self.data
        //return Path.linePathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight))
        return Path.quadCurvedPathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight), globalOffset: Double(minDataValue))
    }
    var closedPath: Path {
        let points = self.data
        return Path.quadClosedCurvedPathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight), globalOffset: Double(minDataValue))
    }
    
    public var body: some View {
        ZStack {
            self.closedPath
//                .fill(LinearGradient(gradient: Gradient(colors: [.clear, .blue]), startPoint: .leading, endPoint: .trailing))
                .fill(Color.blue)
                .opacity(0.8)
                .transition(.opacity)
                .animation(.easeIn(duration: 2))
            self.path
                .trim(from: 0, to: self.showFull ? 1:0)
                .stroke(LinearGradient(gradient: gradient.getGradient(), startPoint: .leading, endPoint: .trailing) ,style: StrokeStyle(lineWidth: 3, lineJoin: .round))
                .animation(Animation.easeOut(duration: 1.2).delay(Double(self.index)*0.4))
                .onAppear {
                    self.showFull = true
                }
        }
    }
    
    func getClosestPointOnPath(touchLocation: CGPoint) -> CGPoint {
        let closest = self.path.point(to: touchLocation.x)
        return closest
    }
    
}

