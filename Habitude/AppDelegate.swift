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
    let notificationManager = NotificationManager.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        FirebaseApp.configure()
        notificationManager.setNotificationCenterDelegate(delegate: self)
        let notificationManager = NotificationManager.shared
        notificationManager.requestAuthorization { granted, error in
            if let error = error {
                print("Error requesting authorization: \(error.localizedDescription)")
            } else if !granted {
                print("Notification authorization not granted")
            } else {
                print("Notification authorization granted")
            }
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.Habitute.primaryDark
        let viewModel =  LoginViewModel( authService: AuthenticationManager(), for: .SIGNUP)
        viewModel.appDelegate = self
        window?.rootViewController = LoginViewController(viewModel: viewModel)
        return true
    }
}

extension AppDelegate: AppDelegateViewOutput {
    
    func goToHomePage(email: String) {
        window?.rootViewController = HabitudeTabBar(email: email)
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let actionIdentifier = response.actionIdentifier
        let notification = response.notification
        let content = notification.request.content
        let userInfo = content.userInfo
        
        switch actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            let viewModel = DrawViewModel(
                habitManager: HabitManager(),
                habitKey: userInfo["habitKey"] as? String
            )
            viewModel.appDelegate = self
            window?.rootViewController = DrawViewController(
                viewModel: viewModel
            )
        case UNNotificationDismissActionIdentifier:
            break
        default:
            break
        }
        completionHandler()
    }
}
