//
//  TimeSet.swift
//  Events_7.03.21
//
//  Created by Alexey Golovnia on 7.03.21.
//

import SwiftUI

struct TimeSet: View {
    
    @EnvironmentObject var arrayEvents: ArrayEvents
    @Binding var elements: Elements
    
        var body: some View {
            
            VStack {
                
                HStack {
                    DatePicker(
                            "Select Time",
                        selection: $elements.date,
                            displayedComponents: [.hourAndMinute]
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                    Toggle(isOn: $elements.toggle) {}
                        .padding()
                }
                
                TextField("Description", text: $elements.description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                CalendarToggle(elements: $elements)
                if !elements.showRepeat {
                    DatePicker(
                            "Select Date",
                        selection: $elements.date,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                } else {
                    HStack {
                        WeekdayButton(elements: $elements, button: "Sun", weekdayInt: 1)
                        WeekdayButton(elements: $elements, button: "Mon", weekdayInt: 2)
                        WeekdayButton(elements: $elements, button: "Tue", weekdayInt: 3)
                        WeekdayButton(elements: $elements, button: "Wed", weekdayInt: 4)
                        WeekdayButton(elements: $elements, button: "Thu", weekdayInt: 5)
                        WeekdayButton(elements: $elements, button: "Fri", weekdayInt: 6)
                        WeekdayButton(elements: $elements, button: "Sat", weekdayInt: 7)
                    }
                }
                
            }
            Spacer()
        }
}

