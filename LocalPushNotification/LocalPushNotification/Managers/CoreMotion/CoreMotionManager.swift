//
//  MotionManager.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 17/06/2022.
//

import CoreMotion

public enum ActivityType {
    case walking, stationary, running, automotive, cycling, unknown
}

typealias ActivityCompletion = ((ActivityType?) -> ())?

protocol CoreMotionManagerProtocol {
    func observeUserActivity(_ completion: ActivityCompletion)
}

class CoreMotionManager: CoreMotionManagerProtocol {

    /// MARK: Constructor
    private init() {}

    /// MARK: Properties
    static let shared = CoreMotionManager()

    private let motionActivityManager = CMMotionActivityManager()
    private let motionManager = CMMotionManager()

    func isMotionPermissionAllowed() -> Bool {
        return CMMotionActivityManager.authorizationStatus() == .authorized
    }

    func observeGyroAccelerometer() {
        motionManager.startGyroUpdates()
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 3

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            if let data = self?.motionManager.accelerometerData {
                let x = data.acceleration.x
                let y = data.acceleration.y
                let z = data.acceleration.z

                print("Accelerometer with x: \(x), y: \(y), z: \(z)")
            }

            if let gyroData = self?.motionManager.gyroData {
                let x = gyroData.rotationRate.x
                let y = gyroData.rotationRate.y
                let z = gyroData.rotationRate.z

                print("Gyro data with x: \(x), y: \(y), z: \(z)")
            }
        }
    }

    func observeUserActivity(_ completion: ActivityCompletion) {
        if (CMMotionActivityManager.isActivityAvailable()) {
            motionActivityManager.startActivityUpdates(to: OperationQueue.main) { activity in
                guard let activity = activity else {
                    completion?(nil)
                    return
                }

                if activity.walking {
                    completion?(.walking)
                } else if activity.stationary {
                    completion?(.stationary)
                } else if activity.running {
                    completion?(.running)
                } else if activity.automotive {
                    completion?(.automotive)
                } else if activity.cycling {
                    completion?(.cycling)
                } else {
                    completion?(.unknown)
                }
            }
        }
    }

}
