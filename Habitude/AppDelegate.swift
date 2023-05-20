//
//  AppDelegate.swift
//  Habitude
//
//  Created by Atacan Sevim on 25.04.2023.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {

        
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.Habitute.primaryDark
        let viewModel =  SignUpViewModel( authService: Authentication(), for: .SIGNUP)
        viewModel.appDelegate = self
        window?.rootViewController = SignUpViewController(viewModel: viewModel)
        return true
    }
}

extension AppDelegate: AppDelegateViewOutput {
    func goToHomePage() {
        window?.rootViewController = HabitudeTabBar()
    }
}
