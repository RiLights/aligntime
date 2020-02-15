/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that hosts the profile viewer and editor.
*/

import SwiftUI

struct ProfileHost: View {
    @EnvironmentObject var user_data: AlignTime
    
    var date_formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 18) {
            Image(systemName: "person.crop.circle")
                .font(.largeTitle)
            List {
                Text("How many aligners do you require:  \(user_data.required_aligners_total)")
                Text("Number of days for each aligners:  \(user_data.aligners_wear_days)")
                Text("Start your treatment:  \(user_data.start_treatment,formatter: date_formatter)")
                Text("Aligner number you are wearing:  \(user_data.aligner_number_now)")
                Text("Days have you been wearing:  \(user_data.current_aligner_days)")
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
                self.user_data.resetDefaults()
                self.user_data.complete = false
                //self.user_data.push_user_defaults()
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
