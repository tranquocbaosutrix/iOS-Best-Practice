//
//  UIView+Extensions.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 10/06/2022.
//

import UIKit

extension UIView {

    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0.0,
                paddingLeft: CGFloat = 0.0,
                paddingBottom: CGFloat = 0.0,
                paddingRight: CGFloat = 0.0,
                width: CGFloat = 0.0,
                height: CGFloat = 0.0,
                enableInsets: Bool = false) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)

        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom

            print("Top: \(topInset)")
            print("bottom: \(bottomInset)")
        }

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.topAnchor.constraint(equalTo: top,
                                      constant: paddingTop + topInset).isActive = true
        }

        if let left = left {
            self.leftAnchor.constraint(equalTo: left,
                                       constant: paddingLeft).isActive = true
        }

        if let right = right {
            rightAnchor.constraint(equalTo: right,
                                   constant: -paddingRight).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom,
                                    constant: -paddingBottom - bottomInset).isActive = true
        }

        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

    }

}
