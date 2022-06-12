//
//  UIAlertController+Extensions.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 01/06/2022.
//

import UIKit

extension UIViewController {
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }

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

    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        handle(notification: notification, showingKeyboard: true)
    }

    @objc private func keyboardWillHide(notification: Notification) {
        handle(notification: notification, showingKeyboard: false)
    }

    private func handle(notification: Notification, showingKeyboard: Bool) {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height,
              let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else {
            return
        }
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       options: UIView.AnimationOptions(rawValue: curve),
                       animations: {
            self.animateConstraints(withKeyboardHeight: keyboardHeight, showingKeyboard: showingKeyboard)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    @objc func animateConstraints(withKeyboardHeight keyboardHeight: CGFloat, showingKeyboard: Bool) { }
}
