//
//  WeekdayButton.swift
//  Events_7.03.21
//
//  Created by Alexey Golovnia on 20.03.21.
//

import SwiftUI

/*struct WeekdayButtons: View {
    
    @Binding var elements: Elements
    
    var weekdayButton: WeekdayButton
    
    var wSunday = WeekdayButton(elements: $elements, button: "Sun")
    var wMonday = WeekdayButton(button: "Mon")
    var wTuesday = WeekdayButton(button: "Tue")
    var wWednesday = WeekdayButton(button: "Wed")
    var wThursday = WeekdayButton(button: "Thu")
    var wFriday = WeekdayButton(button: "Fri")
    var wSaturday = WeekdayButton(button: "Sat")
    
    var body: some View {
        HStack {
            wSunday
            wMonday
            wTuesday
            wWednesday
            wThursday
            wFriday
            wSaturday
        }
    }
}*/

struct WeekdayButton: View {
    
    @Binding var elements: Elements
    var button: String
    var weekdayInt: Int
    
    var body: some View {
        
        Button(action: { self.elements.weekdaysBool[weekdayInt - 1].toggle()
            if elements.weekdaysBool[weekdayInt - 1] {
                elements.weekdaysInt.append(weekdayInt)
            } else {
                for i in 0..<elements.weekdaysInt.count {
                    if elements.weekdaysInt[i] == weekdayInt {
                        elements.weekdaysInt.remove(at: i)
                        break
                    }
                }
            }
        }, label: {
            if elements.weekdaysBool[weekdayInt - 1] {
                Text(button)
                    .font(.system(size: 11))
                    .foregroundColor(.black)
                    .padding(9)
                    .background(Color.init(#colorLiteral(red: 0.5483298898, green: 0.9585216641, blue: 0.9006035924, alpha: 1)))
                    .clipShape(Circle())
            } else {
                Text(button)
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .padding(9)
                    .background(Color.white)
                    .clipShape(Circle())
            }
        })
    }
}

