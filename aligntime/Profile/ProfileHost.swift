/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that hosts the profile viewer and editor.
*/

import SwiftUI

struct ProfileHost: View {
    @EnvironmentObject var user_data: UserData
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 18) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .font(.largeTitle)
                .scaleEffect(1.1)
            List {
                Text("How many aligners do you require:  \(user_data.require_count)")
                Text("Number of days for each aligners:  \(user_data.aligners_count)")
                Text("Start your treatment:  \(user_data.start_treatment)")
                Text("Aligner number you are wearing:  \(user_data.align_count_now)")
                Text("Days have you been wearing:  \(user_data.days_wearing)")
                Text("Complete (Debug):  \(String(user_data.complete))")
            }
            
//            ForEach(0 ..< 7) {
//                Text("\($0)")
//                HStack {
//                    Text("Value")
//                    EditButton()
//                }
//            }
            
            
            Button(action: {
                self.user_data.complete = false
                self.user_data.push_user_defaults()
            }){
                ZStack(alignment: .center){
                    Rectangle()
                        .frame(height: 40)
                        .foregroundColor(Color.blue)
                    Text("Reset Complete (Debug)")
                        .foregroundColor(Color.white)
                }
            }
        }
        .padding()
        .navigationBarItems(trailing: EditButton())
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
    }
}
