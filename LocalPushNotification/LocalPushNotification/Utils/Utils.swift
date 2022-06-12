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

    static func observeKeyboardWillShowNotification(_ scrollView: UIScrollView, onShowHandler onShow: ((CGSize?) -> Void)? = nil) {

        let block: (Notification) -> Void = { notification -> Void in

            guard let keyboardFrameEndUserInfoKey = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] else { return }

            let keyboardSize = (keyboardFrameEndUserInfoKey as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(
                top: scrollView.contentInset.top,
                left: scrollView.contentInset.left,
                bottom: keyboardSize.height,
                right: scrollView.contentInset.right

            )
            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            onShow?(keyboardSize)
        }

        _ = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: nil,
            using: block
        )
    }

    static func observeKeyboardWillHideNotification(_ scrollView: UIScrollView, onHideHandler onHide: ((CGSize?) -> Void)? = nil) {

        let block: (Notification) -> Void = { notification in

            guard let keyboardFrameEndUserInfoKey = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] else { return }

            let keyboardSize = (keyboardFrameEndUserInfoKey as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(
                top: scrollView.contentInset.top,
                left: scrollView.contentInset.left,
                bottom: .zero,
                right: scrollView.contentInset.right
            )
            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            onHide?(keyboardSize)
        }

        _ = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil,
            using: block
        )
    }
}
