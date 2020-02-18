/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that hosts the profile viewer and editor.
*/

import SwiftUI

struct ProfileManager: View {
    @EnvironmentObject var user_data: AlignTime
    @State private var showingAlert = false
    
    private func link<Destination: View>(icon: String, label: String, destination: Destination) -> some View {
        return NavigationLink(destination: destination) {
            HStack {
                Image(systemName: icon)
                Text(label)
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 18) {
            NavigationView {
                List {
                    link(icon: "chart.pie", label: "View Wear Time Statistics", destination: StatisticsView())
                    link(icon: "doc.plaintext", label: "Modify Treatment Plan", destination: TreatmentPlan())
                    link(icon: "calendar.circle", label: "Orthodontist Appointment", destination: OrthodontistAppointment())
                    Button(action: {
                        self.showingAlert = true
                    }){
                        HStack {
                            Image(systemName: "pencil")
                            Text("Give Us Feedback")
                        }
                    }
                }.navigationBarTitle(Text("AlignTime"), displayMode: .automatic)
                .navigationBarItems(trailing: profileButton)
            }

            
//            Image(systemName: "person.crop.circle")
//                .font(.largeTitle)
//            List {
//                Text("How many aligners do you require:  \(user_data.required_aligners_total)")
//                Text("Number of days for each aligners:  \(user_data.aligners_wear_days)")
//                Text("Start your treatment:  \(user_data.start_treatment,formatter: date_formatter)")
//                Text("Aligner number you are wearing:  \(user_data.aligner_number_now)")
//                Text("Days have you been wearing:  \(user_data.current_aligner_days)")
//                Text("Complete (Debug):  \(String(user_data.complete))")
//            }

            
            
//            Button(action: {
//                self.user_data.resetDefaults()
//                self.user_data.complete = false
//                //self.user_data.push_user_defaults()
//            }){
//                ZStack(alignment: .center){
//                    Rectangle()
//                        .frame(height: 40)
//                        .foregroundColor(Color.blue)
//                    Text("Reset Complete (Debug)")
//                        .foregroundColor(Color.white)
//                }
//            }
//        }
//        .padding()
//        .navigationBarItems(trailing: EditButton())
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
