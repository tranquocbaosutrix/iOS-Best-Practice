//
//  MainNotificationManager.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 02/06/2022.
//

import UserNotifications

protocol MainNotificationManagerProtocol {
    func handleNotificationResponse(_ response: UNNotificationResponse)
}

class MainNotificationManager: NSObject, AppPermissionManagerProtocol {
    static let shared = MainNotificationManager()

    private override init() {
        super.init()

        UNUserNotificationCenter.current().delegate = self
    }

    func appPermissionStatus(_ completion: @escaping ((AuthorizationStatus) -> ())) {
        var status: AuthorizationStatus = .notDetermined

        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                status = .authorized
            case .denied:
                status = .denied
            default:
                break
            }

            completion(status)
        }
    }

    func requestAuthorization(_ completion: @escaping((Bool, Error?) ->())) {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]) { granted, error in
                completion(granted, error)
            }
    }
}

/// MARK: Extensions
extension MainNotificationManager: MainNotificationManagerProtocol {
    func handleNotificationResponse(_ response: UNNotificationResponse) {
        print(response)
    }
}

extension MainNotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        MainNotificationManager.shared.handleNotificationResponse(response)
        completionHandler()
    }
}
