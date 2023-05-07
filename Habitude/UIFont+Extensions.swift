//
//  UIFont+Extensions.swift
//  Habitude
//
//  Created by Atacan Sevim on 25.04.2023.
//

import Foundation
import UIKit

extension UIFont {
    
    public class Habitude {
        
        private static let fontFamilyName = "Poppins"
        private static let bold = "-Bold"
        private static let regular = "-Regular"
        private static let medium = "-Medium"
        
        
        static let titleLarge = UIFont(name: "\(fontFamilyName)\(bold)", size: 27)
        static let titleMedium = UIFont(name: "\(fontFamilyName)\(bold)", size: 19)
        static let titleSmall = UIFont(name: "\(fontFamilyName)\(bold)", size: 16)
        
        static let paragraphRegular = UIFont(name: "\(fontFamilyName)\(regular)", size: 16)
        static let paragraphMedium = UIFont(name: "\(fontFamilyName)\(medium)", size: 16)
        static let paragraphSmall = UIFont(name: "\(fontFamilyName)\(regular)", size: 14)
        static let paragraphExtraSmall = UIFont(name: "\(fontFamilyName)\(regular)", size: 12)
        
        static let label = UIFont(name: "\(fontFamilyName)\(bold)", size: 16)
    }
}
