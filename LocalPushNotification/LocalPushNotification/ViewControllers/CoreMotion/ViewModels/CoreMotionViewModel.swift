//
//  CoreMotionViewModel.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 17/06/2022.
//

import Foundation

final class CoreMotionViewModel {

    var userActivityHandler: ((String) -> ())?

    var showRequestMotionDeniedAlert: (() -> ())?

    func checkMotionAuthorizationStatus() {
        if !CoreMotionManager.shared.isMotionPermissionAllowed() {
            showRequestMotionDeniedAlert?()
        }
    }

    func updateUserActivity(_ userActivity: ActivityType?) {
        guard let userActivity = userActivity else { return }
        switch userActivity {
        case .walking:
            userActivityHandler?("User is walking")
        case .running:
            userActivityHandler?("User is running")
        case .automotive:
            userActivityHandler?("User is in automotive mode")
        case .stationary:
            userActivityHandler?("User is in stationary mode")
        case .cycling:
            userActivityHandler?("User is riding a bicycle")
        default:
            userActivityHandler?("User is doing something quite strange")
        }
    }

}
