//
//  CommonMetods.swift
//  Events_7.03.21
//
//  Created by Alexey Golovnia on 15.03.21.
//

import Foundation
import SwiftUI

var tempElement = Elements(
    date: Date(),
    toggle: true,
    description: "здесь надо было что нибудь написать длинное и не влезающее в одну строчку",
    //description: "здесь надо было что нибудь",
    edding: 1,
    temp: 0,
    weekdaysInt: []
)

func rowSingleEvent(_ e: Elements, _ d: Date) -> String {
    let dayAlarm = Calendar.current.component(.day, from: e.dateZeroSecond)
    let dayCurrent = Calendar.current.component(.day, from: d)
    let dif = dayCurrent - dayAlarm
    
    switch dif {
    case 0:
        return "Today"
    case -1:
        return "Tomorrow"
    default:
        return "0"
    }
}

/*func rowWeekdays(_ e: Elements, _ wI: [Int]) -> ([String], [Bool]) {
    let wI = e.weekdaysInt
    let arrStr: [String] = ["s","m","t","w","t","f","s"]
    var arrBool = [Bool] (repeating: false, count: 7)
    
    for i in wI {
        arrBool[i] = true
    }
    
    return (arrStr, arrBool)
}*/

func rowWeekdays(_ e: Elements) -> String {
    
    var returnRow = ""

    let sortArray = e.weekdaysInt.sorted()
    
    for i in sortArray {
        switch i {
                    case 1:
                        returnRow += "Su"
                    case 2:
                        returnRow += "Mo"
                    case 3:
                        returnRow += "Tu"
                    case 4:
                        returnRow += "We"
                    case 5:
                        returnRow += "Th"
                    case 6:
                        returnRow += "Fr"
                    case 7:
                        returnRow += "Sa"
                    default:
                        returnRow = "undefined"
                }
    }
    
    if sortArray.count == 7 {
        return "Every day"
    } else {
        return returnRow
    }
}

func rowCalendar(_ e: Elements, _ d: Date) -> String {
    let monthSet = Calendar.current.component(.month, from: e.dateZeroSecond)
    let monthCurrent = Calendar.current.component(.month, from: d)
    let yearSet = Calendar.current.component(.year, from: e.dateZeroSecond)
    let yearCurrent = Calendar.current.component(.year, from: d)
    
    if monthSet == monthCurrent && yearSet == yearCurrent {
        let dayAlarm = Calendar.current.component(.day, from: e.dateZeroSecond)
        let dayCurrent = Calendar.current.component(.day, from: d)
        let dif = dayCurrent - dayAlarm
        
        switch dif {
        case 1:
            return "Yesterday"
        case 0:
            return "Today"
        case -1:
            return "Tomorrow"
        default:
            return getTimePicker(e, 1)
        }
    } else {
        return getTimePicker(e, 1)
    }
}

func selectionLine(_ e: Elements) -> (String, String) {
    let sr = e.showRepeat
    let wd = e.weekdaysInt.count
    
    if sr && wd == 0 {
        return ("clock", rowSingleEvent(e, Date()))
    } else if !sr {
        return ("calendar", rowCalendar(e, Date()))
    } else {
        return ("clock.arrow.2.circlepath", rowWeekdays(e))
    }
}

func getTimePicker(_ e: Elements, _ cl: Int) -> String {
    let date3 = e.dateZeroSecond
    let dateFormatter = DateFormatter()
    if cl == 0 {
        dateFormatter.dateFormat = "HH:mm"
    } else {
        dateFormatter.dateFormat = "dd.MM.yy EE"
    }
    let date = dateFormatter.string(from: date3)
    return date
}




