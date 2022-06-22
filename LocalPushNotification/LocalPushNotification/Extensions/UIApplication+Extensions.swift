//
//  UIApplication.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 01/06/2022.
//

import UIKit

extension UIApplication {
    static func topViewControllerInNavigationStack() -> UIViewController? {
        if var topController = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            return topController
        }

        return nil
    }
}
