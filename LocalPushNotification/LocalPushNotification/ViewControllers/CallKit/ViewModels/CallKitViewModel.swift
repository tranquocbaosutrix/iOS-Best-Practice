//
//  CallKitViewModel.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 12/06/2022.
//

class CallKitViewModel {

    /// MARK: Properties
    var callCount: Int {
        get {
            return CallManager.shared.calls.count
        }
    }

    func callName(at index: Int) -> String {
        return CallManager.shared.calls[index].handle
    }
}
