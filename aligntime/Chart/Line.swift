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
    @Binding var minDataValue: Double?
    @Binding var maxDataValue: Double?
    @State private var showFull: Bool = false
    @State var showBackground: Bool = true
    var gradient: GradientColor = GradientColor(start: Colors.GradientPurple, end: Colors.GradientNeonBlue)
    var index:Int = 0
    let padding:CGFloat = 30
    var curvedLines: Bool = true
    var stepWidth: CGFloat {
        var min: Double?
        var max: Double?
        let points = self.data
        if minDataValue != nil && maxDataValue != nil {
            min = minDataValue!
            max = maxDataValue!
        }else if let minPoint = points.min(), let maxPoint = points.max(), minPoint != maxPoint {
            min = minPoint
            max = maxPoint
        }else {
            return 0
        }
        if let min = min, let max = max, min != max {
            if (min <= 0){
                return (frame.size.width-padding) / CGFloat(max - min)
            }else{
                return (frame.size.width-padding) / CGFloat(max + min)
            }
        }
        return 0
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
        return Path.quadCurvedPathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight), globalOffset: minDataValue)
    }
    var closedPath: Path {
        let points = self.data
        return Path.quadClosedCurvedPathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight), globalOffset: minDataValue)
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

