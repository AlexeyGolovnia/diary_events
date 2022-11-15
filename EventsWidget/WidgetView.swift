//
//  WidgetView.swift
//  Events_7.03.21
//
//  Created by Alexey Golovnia on 15.03.21.
//

import SwiftUI

struct WidgetView: View {
    
    let events: [Elements]
    let stringDate: [String]
    let colors: [Color]
    
    var body: some View {
        ForEach(events.indices, id:\.self) { value in
            
            VStack {
                HStack {
                    Text("\(getTimePicker(events[value], 0))")
                        .font(.largeTitle)
                        .lineLimit(1)
                    
                    VStack {
                        
                        HStack {
                            Image(systemName: selectionLine(events[value]).0)
                                .imageScale(.small)
                            Text("\(stringDate[value])")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)
                        }
                        
                        Text("\(events[value].dateZeroSecond, style: .relative)")
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                Text("\(events[value].description)")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(colors[value])
        }
    }
}
