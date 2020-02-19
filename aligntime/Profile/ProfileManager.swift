/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that hosts the profile viewer and editor.
*/

import SwiftUI

struct ProfileManager: View {
    @EnvironmentObject var user_data: AlignTime
    @State private var showingAlert = false
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 18) {
            NavigationView {
                List {
                    LinkMenu(icon: "chart.pie", label: "View Wear Time Statistics", destination: StatisticsView())
                    LinkMenu(icon: "doc.plaintext", label: "Modify Treatment Plan", destination: TreatmentPlan())
                    LinkMenu(icon: "list.bullet.indent", label: "Individual Aligner Adjust", destination: IndividualAligner())
                    LinkMenu(icon: "calendar.circle", label: "Orthodontist Appointment", destination: OrthodontistAppointment())
                    LinkMenu(icon: "slowmo", label: "About", destination: About(view_mode: false))
                    Button(action: {
                        self.showingAlert = true
                    }){
                        HStack {
                            Image(systemName: "paperplane")
                            Text("Give Us Feedback")
                        }
                    }
                }.navigationBarTitle(Text("AlignTime"), displayMode: .automatic)
                .navigationBarItems(trailing: profileButton)
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Test"), message: Text("Not Implemented Yet"), dismissButton: .default(Text("Ok")))
        }
    }
}


private var profileButton: some View {
    Button(action: { }) {
        Image(systemName: "person.crop.circle")
    }
}

func LinkMenu<Destination: View>(icon: String, label: String, destination: Destination) -> some View {
    return NavigationLink(destination: destination) {
        HStack {
            Image(systemName: icon)
            Text(label)
        }
    }
}
