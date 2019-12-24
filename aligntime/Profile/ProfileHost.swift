/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that hosts the profile viewer and editor.
*/

import SwiftUI

struct ProfileHost: View {
    var body: some View {
        VStack(alignment: .trailing, spacing: 18) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .font(.largeTitle)
                .scaleEffect(1.1)

            ForEach(0 ..< 7) {
                Text("\($0)")
                HStack {
                    Text("Value")
                    EditButton()
                }
            }
            
            
                
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
    }
}
