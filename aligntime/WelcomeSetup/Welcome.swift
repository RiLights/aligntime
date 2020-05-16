//
//  Init.swift
//  aligntime
//
//  Created by Ostap on 23/12/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import SwiftUI

struct Welcome: View {
    @EnvironmentObject var user_data: AlignTime
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    RoundedRectangle(cornerRadius: 150)
                        .foregroundColor(.accentColor)
                        .frame(width: 300, height: 300)
                        .padding(.top, -250)
                        .blur(radius: 120)
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
                    NavigationLink(destination: InitSetup01().environmentObject(self.user_data)) {
                        ZStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 7)
                                .frame(height: 40)
                            Text(NSLocalizedString("Add your treatment",comment:""))
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal,50)

                    NavigationLink(destination: About()) {
                        ZStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 7)
                                .frame(height: 40)
                                .foregroundColor(Color.secondary)
                            Text(NSLocalizedString("About AlignTime",comment:""))
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom,15)
                    .padding(.horizontal,50)
                }
            }
        }
    }
}

