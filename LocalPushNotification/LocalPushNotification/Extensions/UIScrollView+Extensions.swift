//
//  UIScrollView+Extensions.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 12/06/2022.
//

import UIKit

extension UIScrollView {

    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
        contentInset = edgeInsets
        scrollIndicatorInsets = edgeInsets
    }

    func setContentInsetAndScrollIndicatorInsets(_ height: CGFloat) {
        let contentInsets = UIEdgeInsets(
            top: contentInset.top,
            left: contentInset.left,
            bottom: height,
            right: contentInset.right

        )

        setContentInsetAndScrollIndicatorInsets(contentInsets)
    }

}
