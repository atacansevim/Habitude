//
//  NotificationDetails.swift
//  Habitude
//
//  Created by Atacan Sevim on 14.02.2024.
//

import Foundation

struct NotificationDetails {
    let title: String
    let description: String?
    let dateComponents: [DateComponents]
    
    init(title: String, description: String?, hour: String, minute: String, days: [Int]) {
        self.title = title
        self.description = description
        self.dateComponents = days.map({ day in
            var dateComponents = DateComponents()
            dateComponents.hour = Int(hour)
            dateComponents.minute = Int(minute)
            dateComponents.weekday = day
            return dateComponents
        })
    }
}
