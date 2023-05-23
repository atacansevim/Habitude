//
//  NotificationManager.swift
//  Habitude
//
//  Created by Atacan Sevim on 23.05.2023.
//

import Foundation
import UserNotifications

protocol NotificationManagerDelegate: AnyObject {
    func result(error: Error?)
}

final class NotificationManager {
    
    weak var delegate: NotificationManagerDelegate?
    
    func createPush(title: String, body:String? = nil, day: Int, hour: Int, minute: Int){
        // 1
        let content = UNMutableNotificationContent()
        content.title = title
        if let body = body {
            content.body = body
        }
        
        // 2
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.weekday = day  // Tuesday
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        print(uuidString)
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { [weak self] (error) in
            if error != nil {
               self?.delegate?.result(error: error)
               print("Error")
            }
            DispatchQueue.main.async {
                self?.delegate?.result(error: nil)
            }
        }
    }
}
