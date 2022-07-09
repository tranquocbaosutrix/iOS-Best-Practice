//
//  AppDelegate.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 01/06/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        Utils.setAppMode()

        Utils.setRootView(HomeViewController(),
                          isHasNavigation: true)

        RemoteNotificationManager.shared.registerForRemoteNotifications()

        return true
    }
}
