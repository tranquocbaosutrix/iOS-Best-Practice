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

}
