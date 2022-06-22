//
//  UIAlertAction+Extensions.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 22/06/2022.
//

import UIKit

extension UIAlertAction {

    static func goToSettingsAction() -> UIAlertAction {
        let settingsAction = UIAlertAction(title: "Settings",
                                           style: .default) { _ in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl) { success in
                    print("Settings opened: \(success)")
                }
            }

        }

        return settingsAction
    }

}
