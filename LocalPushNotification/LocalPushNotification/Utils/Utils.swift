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

    static func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }

    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
