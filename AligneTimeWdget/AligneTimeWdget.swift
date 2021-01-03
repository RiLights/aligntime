//
//  AligneTimeWdget.swift
//  AligneTimeWdget
//
//  Created by Yaryna Pochtarenko on 23/09/20.
//  Copyright © 2020 Ostap. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct AligneTimeWdgetEntryView : View {
    var entry: Provider.Entry
    
    var colors = Gradient(colors: [.accentColor, .clear])

    @State var wear_time = "00:00:00"
    @State var off_time = "00:00:00"

    var body: some View {
        //Text(entry.date, style: .time)
        VStack(alignment: .center) {
            Spacer()
            VStack(alignment: .center, spacing: 4) {
                Text(NSLocalizedString("Wear time: ",comment:""))
                    .foregroundColor(Color.primary)
                Text(wear_time)
                    .foregroundColor(Color.blue)
                    .padding(.bottom, 5)
            }
            VStack(alignment: .center, spacing: 0) {
                Text(NSLocalizedString("Out time: ",comment:""))
                    .foregroundColor(Color.primary)
                Text(off_time)
                    .foregroundColor(Color.primary)
            }
            .font(.headline)
            VStack{
                //Spacer()
                RadialGradient(gradient: colors, center: .bottom, startRadius: 1, endRadius: 100)
                    .padding(.bottom, -70)
                    .opacity(0.45)
                
            }
                
        }
        .padding(.bottom, 10)
        //.font(.title)
    }
}

@main
struct AligneTimeWdget: Widget {
    let kind: String = "AligneTimeWdget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            AligneTimeWdgetEntryView(entry: entry)
        }
        .configurationDisplayName("AlignTime")
        .description("AlignTime is a Mobile app, created by users to assist other users in keeping track of Invisalign braces wear time. \n\n AlignTime helps record your daily wear time for each tray, sends reminders if an aligner has been left out for too long and alerts you when it is time to change your tray. You can monitor progress for each aligner wear time using Calendar functionality.")
    }
}

struct AligneTimeWdget_Previews: PreviewProvider {
    static var previews: some View {
        AligneTimeWdgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
