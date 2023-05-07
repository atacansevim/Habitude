//
//  View+Extensions.swift
//  Habitude
//
//  Created by Atacan Sevim on 26.04.2023.
//

import Foundation
import UIKit

public extension UIView {
    
    static func separator(_ height: CGFloat = 2, width: CGFloat? = nil, color: UIColor? = nil) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let width = width {
            view.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        if let color = color {
            view.backgroundColor = color
        } else {
            view.backgroundColor = UIColor(red: 0.263, green: 0.294, blue: 0.325, alpha: 1)
        }
      
        
        return view
    }
}
