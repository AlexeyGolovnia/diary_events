//
//  LocalNotifications.swift
//  Events_7.03.21
//
//  Created by Alexey Golovnia on 11.03.21.
//

import UserNotifications

struct Notification {
    var id: String
    var title: String
    var dateComponents: DateComponents
    var repeats: Bool
    var date: Date

}

class LocalNotificationManager: ObservableObject {
        
    var notifications = [Notification]()
    
    var temp = 0
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications permitted")
            } else {
                print("Notifications not permitted")
            }
        }
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
            }
        }
        
    }
    
    func addNotification(title: String, dateComponents: DateComponents, repeats: Bool, date: Date) -> Void {
        notifications.append(Notification(id: UUID().uuidString, title: title, dateComponents: dateComponents, repeats: repeats, date: date))
    }
    
    func scheduleNotification() {
        
        notifications.sort { $0.date < $1.date }
        var badge: Int = 0
        
        for notification in notifications {
            badge += 1
            
            let content = UNMutableNotificationContent()
            let userActions = "User Actions"
            
            content.title = "New Event!"
            content.body = notification.title
            content.sound = UNNotificationSound.default
            content.badge = NSNumber(value: badge)
            content.categoryIdentifier = userActions
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: notification.dateComponents, repeats: notification.repeats)
            
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Error \(error.localizedDescription)")
                }
            }
            
            let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
            let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
            let category = UNNotificationCategory(identifier: userActions, actions: [snoozeAction, deleteAction], intentIdentifiers: [], options: [])
            
            UNUserNotificationCenter.current().setNotificationCategories([category])
        }
    }
    
}



/*func schedule() -> Void {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
          switch settings.authorizationStatus {
          case .notDetermined:
              requestPermission()
          case .authorized, .provisional:
              scheduleNotification()
          default:
              break
          }
      }
  }

func requestPermission() -> Void {
    UNUserNotificationCenter
        .current()
        .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
            if granted == true && error == nil {
                    self.scheduleNotification()
            }
        }
}*/
