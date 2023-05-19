//
//  Image.swift
//  Habitude
//
//  Created by Atacan Sevim on 2.05.2023.
//

import UIKit

public enum Images: String, CaseIterable {
    case homePageUnselected = "home_unSelected"
    case tickUnselected = "tick_unSelected"
    case gearUnselected = "gear_unSelected"
    case profileUnselected =  "profile_unSelected"
    case shadow
    case arrow
    case profileHeader
    case bug
    case lock
    case plus
    case plusWithBorder
    case mark
    case cross
}

extension Images {
    var image: UIImage {
        return UIImage(named: rawValue)!
    }
}

