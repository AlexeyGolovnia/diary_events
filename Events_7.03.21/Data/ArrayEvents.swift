//
//  ArrayEvents.swift
//  Events_7.03.21
//
//  Created by Alexey Golovnia on 7.03.21.
//

import Foundation
import SwiftUI
import WidgetKit

class ArrayEvents: ObservableObject {
    
    @AppStorage("arrayEvents", store: UserDefaults(suiteName: "group.test223344556677e130221.Events-7-03-21"))
    var nData: Data = Data()
    
    @Published var events = [Elements]() {
        didSet {
            let encoder = JSONEncoder()
            if let nData = try? encoder.encode(events) {
                UserDefaults.standard.set(nData, forKey: "arrayEvents")
                WidgetCenter.shared.reloadTimelines(ofKind: "EventsWidget")
                self.nData = nData
            }
        }
    }
    
    init() {
        if let arrayEvents = UserDefaults.standard.data(forKey: "arrayEvents") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Elements].self, from: arrayEvents) {
                self.events = decoded
                return
            }
        }
    }
    
    func sortedArray3(_ c: Int) -> [Elements] {
        
        var events: [Elements] = []
        let arr = try! JSONDecoder().decode([Elements].self, from: nData)
        events.append(contentsOf: arr)
        
        var arrSorted: [Elements] = []
        for j in 0..<events.count {
            if events[j].toggle == true {
                arrSorted.append(events[j])
            }
        }
        
        arrSorted.sort { $0.dateZeroSecond < $1.dateZeroSecond }
        let k = arrSorted.count < c ? arrSorted.count : c
        var arrSortedRemoved: [Elements] = []
        
        for i in 0..<k {
            arrSortedRemoved.append(arrSorted[i])
        }
        return arrSortedRemoved
    }

}


