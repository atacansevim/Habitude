//
//  UINavigationItem+Extension.swift
//  Habitude
//
//  Created by Atacan Sevim on 9.05.2023.
//
import UIKit

extension UINavigationItem {
    
    public func removeBackBarButtonTitle() {
        backBarButtonItem = BackBarButtonItem(title: "", style: .done, target: nil, action: nil)
    }
}

final class BackBarButtonItem: UIBarButtonItem {
    @available(iOS 14.0, *)
    override var menu: UIMenu? {
        set {
            
        }
        get {
            return super.menu
        }
    }
}
