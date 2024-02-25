//
//  String+Extensions.swift
//  Habitude
//
//  Created by Atacan Sevim on 26.04.2023.
//

import Foundation

public extension String {
    
    static func currentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: Date())
    }

    static func currentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    func toDate(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: self)
    }
    
    func indexInt(of char: Character) -> Int? {
        return firstIndex(of: char)?.utf16Offset(in: self)
    }
    
    static func getUserEmail() -> String {
        let email:String? = KeychainManager.shared.getData(forKey: "userEmail")
        
        if let email {
            return email
        } else {
            return ""
        }
    }
}

public extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}

extension Optional where Wrapped == String {
    
    func safelyUnwrapped(or defaultValue: String = "") -> String {
        if let unwrapped = self {
            return unwrapped
        } else {
            return defaultValue
        }
    }
}
