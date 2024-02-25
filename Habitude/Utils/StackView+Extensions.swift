//
//  StackView+Extensions.swift
//  Habitude
//
//  Created by Atacan Sevim on 19.02.2024.
//

import Foundation
import UIKit

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { subview in
            removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
    }
}
