//
//  DayEnum.swift
//  Habitude
//
//  Created by Atacan Sevim on 16.05.2023.
//

import Foundation

enum Days: Int, CustomStringConvertible
{
    var description: String {
        switch self {
        case .MONDAY:
            return "M"
        case .TUESDAY:
            return "T"
        case .WEDNESDAY:
            return "W"
        case .THURSDAY:
            return "T"
        case .FRIDAY:
            return "F"
        case .SATURDAY:
            return "S"
        case .SUNDAY:
            return "S"
        }
    }
    
    case MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY
}
