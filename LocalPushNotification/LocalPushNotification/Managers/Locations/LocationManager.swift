//
//  LocationManager.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 02/06/2022.
//

import CoreLocation

class LocationManager: AppPermissionManagerProtocol {

    ///MARK: Constructor
    private init() {}

    /// MARK: Properties
    static let shared = LocationManager()

    /// MARK: Functions
    func appPermissionStatus(_ completion: @escaping ((AuthorizationStatus) -> ())) {

    }

    func requestAuthorization(_ completion: @escaping (Bool, Error?) -> ()) {

    }
}
