//
//  Local Notifications.swift
//  Drynk
//
//  Created by Utkarsh Dixit on 29/3/21.
//

import Foundation
import UserNotifications

class LocalNotificationHandler {
    
    static let shared = LocalNotificationHandler()
    private init() {}
    
    func setLocalNotification(title:String,subtitle:String,timeInterval:TimeInterval) ->  Void {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = subtitle
        content.sound = UNNotificationSound.default
        
        //  Create the notification trigger
      
        let date = Date(timeIntervalSinceNow: 3600)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        //  Create the request
        
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        //  Register the request
        center.add(request) { (error) in
            // Check the error parameter and handle any errors
        }
        print("Notif added for\(trigger)")
        
    }
}
