//
//  Habit.swift
//  Habitude
//
//  Created by Atacan Sevim on 13.02.2024.
//

import Foundation

struct Habit: Decodable, Equatable {
    let createdDate: Date
    let title: String
    let description: String?
    let hour: Int
    let minute: Int
    let days: [String: String]
    
    init(createdDate: String, habitDictionary: [String : Any]) {
        self.createdDate = createdDate.toDate() ?? Date()
        self.title = habitDictionary["title"] as! String
        self.description = habitDictionary["description"] as? String
        //TODO CHECK THIS OPTIONAL VALUES
        self.hour = Int(habitDictionary["hour"] as! String) ?? 0
        self.minute = Int(habitDictionary["minute"] as! String) ?? 0
        self.days = habitDictionary["days"] as! [String: String]
    }
}
