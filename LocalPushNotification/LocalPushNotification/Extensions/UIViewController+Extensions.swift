//
//  UIAlertController+Extensions.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 01/06/2022.
//

import UIKit

extension UIViewController {
    func showAlert(_ viewController: UIViewController,
                   title: String,
                   message: String) {
        DispatchQueue.main.async {
            let dialogMessage = UIAlertController(title: title,
                                                  message: message,
                                                  preferredStyle: .alert)

            viewController.present(dialogMessage, animated: true)
        }
    }

    func showAlert(_ viewController: UIViewController,
                   title: String,
                   message: String,
                   actions: [UIAlertAction]) {
        DispatchQueue.main.async {
            if actions.isEmpty {
                return
            }

            let dialogMessage = UIAlertController(title: title,
                                                  message: message,
                                                  preferredStyle: .alert)

            for action in actions {
                dialogMessage.addAction(action)
            }

            viewController.present(dialogMessage, animated: true)
        }
    }

    func dismissAllPresentedAlertViewController() {
        DispatchQueue.main.async {
            let viewController = UIApplication.topViewControllerInNavigationStack()
            guard let isKindOf = viewController?.isKind(of: UIAlertController.classForCoder()), isKindOf else { return }
            viewController?.dismiss(animated: false)
        }
    }
}
