//
//  Init.swift
//  aligntime
//
//  Created by Ostap on 23/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        NavigationView {
            VStack{
                VStack(alignment: .center){
                    Text("Welcome to AlignTime")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 30)
                        .multilineTextAlignment(.center)
                        .scaleEffect(1.1)
                    Text("Your assistant on the way to a perfect smile")
                        .font(.body)
                        .padding(.vertical,10)
                        .padding(.horizontal, 100)
                        .multilineTextAlignment(.center)

                }
                .padding(.top, 50)
                Spacer()
                NavigationLink(destination: WelcomeInfo()) {
                    Text("Add your treatment")
                        .font(.headline)
                        .padding(12)
                        .padding(.horizontal,20)
                        .background(Color.blue)
                        .cornerRadius(3)
                        .foregroundColor(.white)
                }
                .padding(8)
                
                NavigationLink(destination: About()) {
                    Text("About AlignTime")
                        .font(.headline)
                        .padding(12)
                        .padding(.horizontal,30)
                        .background(Color.secondary)
                        .cornerRadius(3)
                        .foregroundColor(.white)
                        //.opacity(0.5)
                }
                .padding(15)
            }

//            .onAppear {
//                self.isNavigationBarHidden = true
//            }
        }
    }
}

