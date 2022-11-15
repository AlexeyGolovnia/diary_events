//
//  NotificationTestApp.swift
//  NotificationTest
//
//  Created by Alexey Golovnia on 2.03.21.
//

import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
            -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notifications with the Local Notification Identifier")
        }
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Snooze":
            print("Snooze")
        case "Delete":
            print("Delete")
        default:
            print("Unknown action")
        }
        
        completionHandler()
        
    }
    
}

@main
struct Events_7_03_21App: App {
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var arrayEvents = ArrayEvents()
    @ObservedObject var notificationManager = LocalNotificationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(arrayEvents)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                UIApplication.shared.applicationIconBadgeNumber = 0
                
                UNUserNotificationCenter.current().getPendingNotificationRequests() { delivered in
                    
                    for i in arrayEvents.events.indices {
                        var k = 0
                        
                        arrayEvents.events[i].temp = delivered.count
                        
                        if arrayEvents.events[i].toggle && arrayEvents.events[i].showRepeat && arrayEvents.events[i].weekdaysInt.count == 0 {
                            
                            for j in delivered {
                                if j.identifier == arrayEvents.events[i].notId {
                                    k = 1
                                    break
                                }
                            }
                            
                            if k == 0 {
                                arrayEvents.events[i].toggle = false
                            }
                            
                        }
                    }
                }
            }
            
            if phase == .background {
                
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                
                notificationManager.notifications.removeAll()
                
                
                
                for i in arrayEvents.events.indices {
                    if arrayEvents.events[i].toggle {
                        
                        for j in arrayEvents.events[i].weekdaysInt {
                            
                            let dateComponentsRepeat = DateComponents(
                                hour: Calendar.current.component(.hour, from: arrayEvents.events[i].dateZeroSecond),
                                minute: Calendar.current.component(.minute, from: arrayEvents.events[i].dateZeroSecond),
                                weekday: j)
                            
                            let date = Calendar.current.nextDate(after: Date(), matching: dateComponentsRepeat, matchingPolicy: .nextTime, direction: .forward)!
                            
                            notificationManager.addNotification(title: arrayEvents.events[i].description, dateComponents: dateComponentsRepeat, repeats: true, date: date)
                        }
                        
                        let date = arrayEvents.events[i].dateZeroSecond
                        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: arrayEvents.events[i].dateZeroSecond)
                        
                        if arrayEvents.events[i].weekdaysInt.count == 0 {
                            
                            notificationManager.addNotification(title: arrayEvents.events[i].description, dateComponents: dateComponents, repeats: false, date: date)
                            
                            arrayEvents.events[i].notId = notificationManager.notifications[notificationManager.notifications.count - 1].id
                            
                        }
                        
                    }
                }
                notificationManager.scheduleNotification()
            }
        }
    }
}


