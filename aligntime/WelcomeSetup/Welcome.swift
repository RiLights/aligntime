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
            ZStack{
                VStack{
                    RoundedRectangle(cornerRadius: 150)
                        .foregroundColor(.accentColor)
                        .frame(width: 300, height: 300)
                        .padding(.top, -250)
                        .blur(radius: 100)
                        .opacity(0.3)
                    Spacer()
                }
                VStack{
                    VStack(alignment: .center){
                        Text(NSLocalizedString("Welcome to AlignTime",comment:""))
                            .font(.system(size: 54))
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 30)
                            .multilineTextAlignment(.center)
                            .scaleEffect(1.1)
                        Text(NSLocalizedString("Your assistant on the way to a perfect smile",comment:""))
                            .font(.system(size: 27))
                            .padding(.vertical,20)
                            .padding(.horizontal, 20)
                            .multilineTextAlignment(.center)

                    }
                    .padding(.top, 50)
                    Spacer()
                    NavigationLink(destination: WelcomeInfo()) {
                        Text(NSLocalizedString("Add your treatment",comment:""))
                            .font(.headline)
                            .padding(12)
                            .padding(.horizontal,20)
                            .background(Color.blue)
                            .cornerRadius(3)
                            .foregroundColor(.white)
                    }
                    .padding(8)

                    NavigationLink(destination: About()) {
                        Text(NSLocalizedString("About AlignTime",comment:""))
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
            }
        }
    }
}

