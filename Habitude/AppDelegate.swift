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
        let center = UNUserNotificationCenter.current()
         center.delegate = self
         
         UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]) {(accepted, error) in
             if !accepted {
                 print("Notification access denied")
             }
         }
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

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        
        completionHandler( [.alert, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
