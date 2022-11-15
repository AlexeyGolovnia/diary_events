//
//  EventsWidget.swift
//  EventsWidget
//
//  Created by Alexey Golovnia on 7.03.21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    let aE = ArrayEvents()
    
    func sortedColors3(_ e: [Elements], _ d: Date) -> [Color] {
        var arrColor: [Color] = []
        
        for i in 0..<e.count {
            if e[i].eddingSeconds > d {
                arrColor.append(Color("myBlackWhite"))
            } else if e[i].dateZeroSecond > d {
                arrColor.append(Color("myYellow"))
            } else {
                arrColor.append(.red)
            }
        }
        return arrColor
    }
    
    func selectionLineWidget(_ e: [Elements], _ d: Date) -> [String] {
        
        var stringDate: [String] = []
        
        for i in e.indices {
            let sr = e[i].showRepeat
            let wd = e[i].weekdaysInt.count
        
            if sr && wd == 0 {
                stringDate.append(rowSingleEvent(e[i], d))
            } else if !sr {
                stringDate.append(rowCalendar(e[i], d))
            } else {
                stringDate.append(rowWeekdays(e[i]))
            }
        }
        
        return stringDate
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), stringDate: [], colors: [])
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), stringDate: [], colors: [])
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        var events: [Elements] = []
        var stringDate: [String] = []
        var colors: [Color] = []
        
        //guard let arr = try? JSONDecoder().decode([Elements].self, from: nData) else { return }
        events.append(contentsOf: aE.sortedArray3(7))
        
        colors.append(contentsOf: sortedColors3(events, Date()))
        stringDate.append(contentsOf: selectionLineWidget(events, Date()))
        entries.append(SimpleEntry(date: Date(), stringDate: stringDate, colors: colors))
        
        //stringDate
        let date = Date()
        let dateComponents = DateComponents(hour: 0, minute: 0)
        let nextDate = Calendar.current.nextDate(after: date, matching: dateComponents, matchingPolicy: .nextTime, direction: .forward)!
        
        for j in 0...60 {
            let date = Calendar.current.date(byAdding: .day, value: j, to: nextDate)!
            
            colors.removeAll()
            stringDate.removeAll()
            colors.append(contentsOf: sortedColors3(events, date))
            stringDate.append(contentsOf: selectionLineWidget(events, date))
            let entry3 = SimpleEntry(date: date, stringDate: stringDate, colors: colors)
            entries.append(entry3)
        }
        
        //цвета
        for i in 0..<events.count {
            let date1 = events[i].dateZeroSecond
            let date2 = events[i].eddingSeconds
            
            colors.removeAll()
            stringDate.removeAll()
            colors.append(contentsOf: sortedColors3(events, date1))
            stringDate.append(contentsOf: selectionLineWidget(events, date1))
            let entry = SimpleEntry(date: date1, stringDate: stringDate, colors: colors)
            entries.append(entry)
            
            colors.removeAll()
            stringDate.removeAll()
            colors.append(contentsOf: sortedColors3(events, date2))
            stringDate.append(contentsOf: selectionLineWidget(events, date2))
            let entry2 = SimpleEntry(date: date2, stringDate: stringDate, colors: colors)
            entries.append(entry2)
        }

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let stringDate: [String]
    let colors: [Color]
}

struct EventsWidgetEntryView : View {
    var entry: Provider.Entry
    
    let aE = ArrayEvents()
    
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            WidgetView(events: aE.sortedArray3(2), stringDate: entry.stringDate, colors: entry.colors)
        case .systemMedium:
            WidgetView(events: aE.sortedArray3(2), stringDate: entry.stringDate, colors: entry.colors)
        case .systemLarge:
            WidgetView(events: aE.sortedArray3(5), stringDate: entry.stringDate, colors: entry.colors)
        @unknown default:
            WidgetView(events: aE.sortedArray3(2), stringDate: entry.stringDate, colors: entry.colors)
        }
    }
}

@main
struct EventsWidget: Widget {
    let kind: String = "EventsWidget"
    @Environment(\.colorScheme) var colorScheme

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            EventsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

