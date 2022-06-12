//
//  LocationManager.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 02/06/2022.
//

import CoreLocation

class LocationManager: AppPermissionManagerProtocol {

    let shared = LocationManager()

    private init() {}

    func appPermissionStatus(_ completion: @escaping ((AuthorizationStatus) -> ())) {

    }

    func requestAuthorization(_ completion: @escaping (Bool, Error?) -> ()) {

    }
}
