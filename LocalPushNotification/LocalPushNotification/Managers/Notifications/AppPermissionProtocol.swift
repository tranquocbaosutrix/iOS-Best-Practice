//
//  AppPermissionProtocol.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 01/06/2022.
//

import Foundation

enum AuthorizationStatus {
    case authorized
    case denied
    case notDetermined
}

protocol AppPermissionManagerProtocol {
    func appPermissionStatus(_ completion: @escaping((AuthorizationStatus) -> ()))
    func requestAuthorization(_ completion: @escaping(Bool, Error?) -> ())
}
