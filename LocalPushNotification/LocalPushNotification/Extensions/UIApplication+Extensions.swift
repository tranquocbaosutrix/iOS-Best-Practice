//
//  UIApplication.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 01/06/2022.
//

import UIKit

extension UIApplication {
    static func topViewControllerInNavigationStack(_ controller: UIViewController? = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewControllerInNavigationStack(navigationController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewControllerInNavigationStack(selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return topViewControllerInNavigationStack(presented)
        }
        
        return controller
    }
}
