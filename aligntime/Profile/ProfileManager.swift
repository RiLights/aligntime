/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that hosts the profile viewer and editor.
*/

import SwiftUI


struct ProfileManager: View {
    @EnvironmentObject var user_data: AlignTime
    @State var reset_alert = false
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 18) {
            NavigationView {
                List {
                    LinkMenu(icon: "chart.pie", label: NSLocalizedString("Time Statistics",comment: ""), destination: StatisticsView())
                    LinkMenu(icon: "doc.plaintext", label: NSLocalizedString("Modify Treatment Plan",comment: ""), destination: TreatmentPlan())
                    LinkMenu(icon: "list.bullet.indent", label: NSLocalizedString("Individual Aligner Adjust",comment: ""), destination: IndividualAlignerManager())

                    //LinkMenu(icon: "calendar.circle", label: "Orthodontist Appointment", destination: OrthodontistAppointment())
                    LinkMenu(icon: "rectangle.3.offgrid", label: NSLocalizedString("Display",comment: ""), destination: DisplaySettings())
                    Button(action: {
                        self.reset_alert = true
                    }){
                        HStack(spacing:13) {
                            Image(systemName: "doc")
                            Text(NSLocalizedString("Reset All History",comment: ""))
                        }
                    }
                    LinkMenu(icon: "slowmo", label: NSLocalizedString("About",comment: ""), destination: About(view_mode: false))
                    Button(action: {
                        self.rateApp(id:"1497677812")
                    }){
                        HStack(spacing:10) {
                            Image(systemName: "paperplane")
                            Text(NSLocalizedString("Give Us Feedback",comment: ""))
                        }
                    }
                }.navigationBarTitle(Text("AlignTime"), displayMode: .automatic)
                .navigationBarItems(trailing: profileButton)
                .alert(isPresented: self.$reset_alert) {
                            Alert(title: Text(NSLocalizedString("Reset All History",comment:"")), message: Text(NSLocalizedString("""
                Do you want to erase all history?
                """,comment:"")), primaryButton: .destructive(Text(NSLocalizedString("Erase",comment:""))) {
                                    self.user_data.set_default_values()
                                    self.user_data.update_min_max_dates()
                                },secondaryButton: .cancel())
                }
            }
        }
    }
    func rateApp(id : String) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/id\(id)?mt=8&action=write-review") else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    private var profileButton: some View {
        Button(action: { }) {
            Image(systemName: "person.crop.circle")
        }
    }

    func LinkMenu<Destination: View>(icon: String, label: String, destination: Destination) -> some View {
        self.user_data.update_individual_aligners()
        return NavigationLink(destination: destination) {
            HStack {
                Image(systemName: icon)
                    .frame(width: 20)
                Text(label)
                    //.padding(.leading,3)
            }
        }
    }
}


