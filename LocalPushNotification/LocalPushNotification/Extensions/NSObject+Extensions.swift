//
//  NSObject+Extensions.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 12/06/2022.
//

import Foundation

extension NSObject {

    static var className: String {
        return String(describing: self)
    }

}
