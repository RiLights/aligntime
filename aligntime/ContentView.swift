//
//  ContentView.swift
//  aligntime
//
//  Created by Ostap on 26/11/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct ContentView: View {
    @EnvironmentObject var user_data: AlignTime
    @State private var hideHorizontalLines: Bool = false
    //let hours:[Int] = [0,3,6,9,12,15,18,21,24]
    
    var body: some View {
        //StatisticsView()
        Group{
            if user_data.complete == true {
                //ZStack{
                    Home().environmentObject(user_data)
//                    VStack{
//                        Image(systemName: "lightbulb")
//                            .padding()
//                        Text("What you would like to explain for artist here?")
//                            .font(.body)
//                            .padding()
//                    }
//                    .frame(width: 250, height: 350)
//                    .background(Blur(style: .systemUltraThinMaterial))
//                }
            }
            else{
                Welcome().environmentObject(user_data)
                }
        }
    }
}

