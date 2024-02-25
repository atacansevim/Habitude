//
//  NotificationManager.swift
//  Habitude
//
//  Created by Atacan Sevim on 14.02.2024.
//

import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private init() {}
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            completion(granted, error)
        }
    }
    
    func scheduleMultipleNotifications(habitKey: String, notificationDetails: NotificationDetails, completion: @escaping (Result<[String:String], Error>) -> Void) {
        let group = DispatchGroup()
        var errors: [Error] = []
        var ids: [String:String] = [:]

        for notificationDetail in notificationDetails.dateComponents {
            group.enter()

            let content = UNMutableNotificationContent()
            content.title = notificationDetails.title
            content.userInfo = [
                "habitKey": habitKey
            ]
            //content.body = notificationDetails.description

            let trigger = UNCalendarNotificationTrigger(dateMatching: notificationDetail, repeats: true)
            let id = UUID().uuidString
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            guard let day = notificationDetail.weekday else {
                return
            }
            ids[String(day)] = id

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    errors.append(error)
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            if errors.isEmpty {
                completion(.success(ids))
            } else {
                completion(.failure(errors.first!))
            }
        }
    }
    
    func cancelNotification(identifier: [String]) {
        for id in identifier {
           UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        }
    }
    
    func setNotificationCenterDelegate(delegate: UNUserNotificationCenterDelegate) {
            notificationCenter.delegate = delegate
    }
}
