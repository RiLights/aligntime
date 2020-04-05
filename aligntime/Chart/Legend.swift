//
//  Legend.swift
//  LineChart
//
//  Created by András Samu on 2019. 09. 02..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct Legend: View {
    @ObservedObject var data: ChartData
    @Binding var frame: CGRect
    @Binding var hideHorizontalLines: Bool
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    let padding:CGFloat = 1
    let divisions:Double = 10

    var stepWidth: CGFloat {
        if data.points.count < 2 {
            return 0
        }
        return frame.size.width / CGFloat(data.points.count-1)
    }
    var stepHeight: CGFloat {
        let points = self.data.onlyPoints()
        if let min = points.min(), let max = points.max(), min != max {
            if (min < 0){
                return (frame.size.height-padding) / CGFloat(max - min)
            }else{
                return (frame.size.height-padding) / CGFloat(max + min)
            }
        }
        return 0
    }
    
    var min: CGFloat {
        let points = self.data.onlyPoints()
        return CGFloat(points.min() ?? 0)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            ForEach((0...Int(divisions)), id: \.self) { height in
                HStack(alignment: .center){
                    Text("\(self.getYLegendSafe(height: height), specifier: "%.2f")").offset(x: 0, y: self.getYposition(height: height) )
                        .foregroundColor(Colors.LegendText)
                        .font(.caption)
                    self.line(atHeight: self.getYLegendSafe(height: height), width: self.frame.width)
                        .stroke(self.colorScheme == .dark ? Colors.LegendDarkColor : Colors.LegendColor, style: StrokeStyle(lineWidth: 1.5, lineCap: .round, dash: [5,height == 0 ? 0 : 10]))
                        .opacity((self.hideHorizontalLines && height != 0) ? 0 : 1)
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .animation(.easeOut(duration: 0.2))
                        .clipped()
                }
            }
        }
    }
    
    func getYLegendSafe(height:Int)->CGFloat{
        if let legend = getYLegend() {
            return CGFloat(legend[height])
        }
        return 0
    }
    
    func getXLegendSafe(height:Int)->CGFloat{
        if let legend = getXLegend() {
            return CGFloat(legend[height])
        }
        return 0
    }
    
    func getYposition(height: Int)-> CGFloat {
        if let legend = getYLegend() {
            return (self.frame.height-((CGFloat(legend[height]) - min)*self.stepHeight))-(self.frame.height/2)
        }
        return 0
    }
    
    func getXposition(width: Int)-> CGFloat {
        if let legend = getXLegend() {
            return (self.frame.width-((CGFloat(legend[width]) - min)*self.stepHeight))-(self.frame.width/2)
        }
        return 0
    }
    
    func line(atHeight: CGFloat, width: CGFloat) -> Path {
        var hLine = Path()
        hLine.move(to: CGPoint(x:5, y: (atHeight-min)*stepHeight))
        hLine.addLine(to: CGPoint(x: width, y: (atHeight-min)*stepHeight))
        return hLine
    }
    
    func getYLegend() -> [Double]? {
        let points = self.data.onlyPoints()
        guard let max = points.max() else { return nil }
        guard let min = points.min() else { return nil }
        let step = Double(max - min)/divisions
        var result:[Double] = []
        for i in (0...Int(divisions)){
            result.append(min+step * Double(i))
        }
        return result
    }
    
    func getXLegend() -> [Int]? {
        let points = self.data.onlyPoints()
        guard let max = points.max() else { return nil }
        guard let min = points.min() else { return nil }
        let step = Double(max - min)/divisions
        var result:[Int] = []
        for i in (1...24){
            result.append(100*i)
        }
        return result
    }

}