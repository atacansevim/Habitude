//
//  UIViewController+Utils.swift
//  Habitude
//
//  Created by Atacan Sevim on 2.05.2023.
//

import UIKit

extension UIViewController {
    
    /*func setStatusBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground() // to hide Navigation Bar Line also
        navBarAppearance.backgroundColor = UIColor.Habitute.primaryDark
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
    }*/
    
    /*func setTabBarImage(image: UIImage) {
        let configuration = UIImage.SymbolConfiguration(scale: .medium)
        tabBarItem = UITabBarItem(title: nil, image: image, tag: 0)
    }*/
    
    func showErrorDialog(for message: String? = "There is something went wrong") {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
            @unknown default:
                print("")
            }
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
