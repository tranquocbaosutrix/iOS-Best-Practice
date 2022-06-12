//
//  Utils.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 01/06/2022.
//

import UIKit

class Utils {
    static func setRootView(_ viewController: UIViewController,
                            isHasNavigation: Bool = false) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        appDelegate.window?.rootViewController = isHasNavigation ? UINavigationController(rootViewController: viewController) : viewController
        appDelegate.window?.makeKeyAndVisible()
    }

    static func setAppMode(_ mode: UIUserInterfaceStyle = .light) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        appDelegate.window?.overrideUserInterfaceStyle = mode
    }

    static func getStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0

        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }

        return statusBarHeight
    }
}
