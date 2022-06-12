//
//  LocalNotificationManager.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 02/06/2022.
//

import CoreLocation
import UserNotifications

protocol LocalNotificationManagerProtocol {
    func sendTimeIntervalLocalNotification(_ title: String,
                                           _ body: String,
                                           _ subTitle: String,
                                           _ sound: UNNotificationSound,
                                           _ timeInterval: TimeInterval,
                                           _ repeats: Bool)
    func sendCalendarLocalNotification(_ title: String,
                                       _ body: String,
                                       _ dateMatching: DateComponents,
                                       _ subTitle: String,
                                       _ sound: UNNotificationSound,
                                       _ repeats: Bool)
    func sendLocationLocalNotification(_ title: String,
                                       _ body: String,
                                       _ region: CLRegion,
                                       _ subTitle: String,
                                       _ sound: UNNotificationSound,
                                       _ repeats: Bool)
}

class LocalNotificationManager: LocalNotificationManagerProtocol {
    static let shared = LocalNotificationManager()

    private init() {}

    func sendTimeIntervalLocalNotification(_ title: String,
                                           _ body: String,
                                           _ subTitle: String = "",
                                           _ sound: UNNotificationSound = .default,
                                           _ timeInterval: TimeInterval = 1.0,
                                           _ repeats: Bool = false) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subTitle
        content.body = body
        content.sound = sound

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval,
                                                        repeats: repeats)

        let request = UNNotificationRequest(identifier: "TimeIntervalLocalNotification",
                                            content: content,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

    func sendCalendarLocalNotification(_ title: String,
                                       _ body: String,
                                       _ dateMatching: DateComponents,
                                       _ subTitle: String = "",
                                       _ sound: UNNotificationSound = .default,
                                       _ repeats: Bool = false) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subTitle
        content.body = body
        content.sound = sound

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateMatching,
                                                    repeats: repeats)

        let request = UNNotificationRequest(identifier: "CalendarLocalNotification",
                                            content: content,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

    func sendLocationLocalNotification(_ title: String,
                                       _ body: String,
                                       _ region: CLRegion,
                                       _ subTitle: String = "",
                                       _ sound: UNNotificationSound = .default,
                                       _ repeats: Bool = false) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subTitle
        content.body = body
        content.sound = sound

        let trigger = UNLocationNotificationTrigger(region: region,
                                                    repeats: repeats)

        let request = UNNotificationRequest(identifier: "LocationLocalNotification",
                                            content: content,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}
