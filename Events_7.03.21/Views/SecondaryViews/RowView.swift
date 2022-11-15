//
//  RowView.swift
//  Events_7.03.21
//
//  Created by Alexey Golovnia on 7.03.21.
//

import SwiftUI

struct RowView: View {
    
    @Binding var elements: Elements
    
    func colors(_ e: Elements) -> Color {
        if !e.toggle {
            return .gray
        } else if e.eddingSeconds > Date()  {
            return Color("myBlackWhite")
        } else if e.dateZeroSecond > Date() {
            return Color("myYellow")
        } else {
            return .red
        }
    }
    
    var body: some View {
        VStack {
            
            //Text("\(elements.temp)")
            
            HStack {
                Text("\(getTimePicker(elements, 0))")
                    .font(.largeTitle)
                    .lineLimit(1)
                VStack {
                    
                    HStack {
                        Image(systemName: selectionLine(elements).0)
                            .imageScale(.small)
                        Text(selectionLine(elements).1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                    }
                    
                    Text("\(elements.dateZeroSecond, style: .relative)")
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                }
                Toggle(isOn: $elements.toggle) {}
                    .frame(width: 50)
                    //.padding(10)
            }
            Text("\(elements.description)")
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(colors(elements))
    }
}

