//
//  WeekdayButton.swift
//  Events_7.03.21
//
//  Created by Alexey Golovnia on 20.03.21.
//

import SwiftUI

struct CalendarToggle: View {
    
    @Binding var elements: Elements
    
    var body: some View {
        HStack {
            Button(action: {elements.showRepeat = true}, label: {
                if elements.showRepeat {
                    Text("Repeat")
                        .foregroundColor(.black)
                        .background(Color.init(#colorLiteral(red: 0.5483298898, green: 0.9585216641, blue: 0.9006035924, alpha: 1)))
                } else {
                    Text("Repeat")
                        .foregroundColor(.gray)
                        .background(Color.white)
                }
            })
            
            Button(action: {elements.showRepeat = false}, label: {
                if !elements.showRepeat {
                    Text("Calendar")
                        .foregroundColor(.black)
                        .background(Color.init(#colorLiteral(red: 0.5483298898, green: 0.9585216641, blue: 0.9006035924, alpha: 1)))
                } else {
                    Text("Calendar")
                        .foregroundColor(.gray)
                        .background(Color.white)
                }
            })
        }
    }
}

