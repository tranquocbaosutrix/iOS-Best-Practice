//
//  UIColor+Extensions.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 09/07/2022.
//

import UIKit

extension UIColor {

    func toRGBAString(uppercased: Bool = true) -> String {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            self.getRed(&r, green: &g, blue: &b, alpha: &a)
            let rgba = [r, g, b, a].map { $0 * 255 }.reduce("", { $0 + String(format: "%02x", Int($1)) })
            return uppercased ? rgba.uppercased() : rgba
        }

}
