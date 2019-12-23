//
//  Init.swift
//  aligntime
//
//  Created by Ostap on 23/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct Init: View {
    var body: some View {
        NavigationView {
            VStack{
                VStack(alignment: .center){
                    Text("Welcome To AlignTime")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 30)
                        .multilineTextAlignment(.center)
                    Text("Your assistant on the way to a perfect smile")
                        .font(.footnote)
                        .padding(.horizontal, 100)
                        .multilineTextAlignment(.center)

                }
                .padding(.top, 50)
                Spacer()
                Button(action: {
                    print("skip")
                }) {
                    Text("Add your treatment")
                        .font(.headline)
                        .padding(12)
                        .padding(.horizontal,20)
                        .background(Color.blue)
                        .cornerRadius(3)
                        .foregroundColor(.white)
                }
                .padding(8)

                NavigationLink(destination: Home()) {
                    Text("Skip")
                        .font(.headline)
                        .padding(12)
                        .padding(.horizontal,77)
                        .background(Color.blue)
                        .cornerRadius(3)
                        .foregroundColor(.white)
                }
                .padding(15)
            }
        }
    }
}

