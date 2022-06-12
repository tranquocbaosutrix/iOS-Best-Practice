//
//  NotificationsManager.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 01/06/2022.
//

import UIKit
import CoreLocation
import UserNotifications

protocol RemoteNotificationManagerProtocol {
    func registerForRemoteNotifications()
    func didFailToRegisterRemoteNotifications(_ error: Error)
    func didReceiveRemoteNotificationToken(_ deviceToken: Data)
}

class RemoteNotificationManager: RemoteNotificationManagerProtocol {
    static let shared = RemoteNotificationManager()

    private init() {}

    func registerForRemoteNotifications() {
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }

    func didFailToRegisterRemoteNotifications(_ error: Error) {
        print("Registering remote notifications failed with \(error.localizedDescription)")
    }

    func didReceiveRemoteNotificationToken(_ deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print(token)
    }
}

/// MARK: Extensions
extension AppDelegate {
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        RemoteNotificationManager.shared.didReceiveRemoteNotificationToken(deviceToken)
    }

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        RemoteNotificationManager.shared.didFailToRegisterRemoteNotifications(error)
    }
}
