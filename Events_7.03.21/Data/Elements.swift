//
//  Elements.swift
//  Events_7.03.21
//
//  Created by Alexey Golovnia on 7.03.21.
//

import Foundation
import SwiftUI

struct Elements: Codable {
    
    var date: Date
    var dateComponents: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
    }
    
    var dateZeroSecond: Date {
        var dateComponentsRepeat = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        if showRepeat {
            if weekdaysInt.count > 0 {
                dateComponentsRepeat = DateComponents(year: 2030)
            }
            
            for i in weekdaysInt {
                let temp1 = DateComponents(hour: Calendar.current.component(.hour, from: date), minute: Calendar.current.component(.minute, from: date), weekday: i)
                if Calendar.current.nextDate(after: Date(), matching: temp1, matchingPolicy: .nextTime)! <= Calendar.current.nextDate(after: Date(), matching: dateComponentsRepeat, matchingPolicy: .nextTime)! {
                
                    dateComponentsRepeat = DateComponents(hour: Calendar.current.component(.hour, from: date), minute: Calendar.current.component(.minute, from: date), weekday: i)
                }
            }
            
            return Calendar.current.nextDate(after: Date(), matching: dateComponentsRepeat, matchingPolicy: .nextTime, direction: .forward)!
            
        } else {
            return Calendar.current.date(from: dateComponents)!
        }
    }
    
    var toggle: Bool
    var description: String
    
    var edding: Double
    var eddingSeconds: Date {
        return Date(timeInterval: -edding * 60 * 60, since: dateZeroSecond)
    }
    
    var temp: Int
    var notId: String = ""
    
    var showRepeat = true
    
    var weekdaysInt: [Int]
    var weekdaysBool = [Bool] (repeating: false, count: 7)
            
}

