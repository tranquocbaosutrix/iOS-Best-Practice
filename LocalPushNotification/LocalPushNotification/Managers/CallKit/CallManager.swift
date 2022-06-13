//
//  CallManager.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 13/06/2022.
//

import Foundation
import CallKit

class CallManager {

    /// MARK: Constructor
    private init() {}

    /// MARK: Properties
    static let shared = CallManager()

    /// MARK: Properties
    var callsChangedHandler: (() -> ())?

    private let callController = CXCallController()

    private(set) var calls: [Call] = []

    /// MARK: Functions
    func callWithUUID(uuid: UUID) -> Call? {
        guard let index = calls.firstIndex(where: { $0.uuid == uuid }) else {
            return nil
        }

        return calls[index]
    }

    func add(call: Call) {
        calls.append(call)
        call.stateChanged = { [weak self] in
            self?.callsChangedHandler?()
        }
        callsChangedHandler?()
    }

    func remove(call: Call) {
        guard let index = calls.firstIndex(where: { $0 === call })
        else { return }
        calls.remove(at: index)
        callsChangedHandler?()
    }

    func removeAllCalls() {
        calls.removeAll()
        callsChangedHandler?()
    }

    private func requestTransaction(_ transaction: CXTransaction) {
        callController.request(transaction) { error in
            if let error = error {
                print("Requesting transaction failed with \(error.localizedDescription)")
            } else {
                print("Requested transaction successfully")
            }
        }
    }

    func end(call: Call) {
        let endCallAction = CXEndCallAction(call: call.uuid)
        let transaction = CXTransaction(action: endCallAction)

        requestTransaction(transaction)
    }

    func setHeld(call: Call, onHold: Bool) {
        let setHeldCallAction = CXSetHeldCallAction(call: call.uuid, onHold: onHold)
        let transaction = CXTransaction(action: setHeldCallAction)
        transaction.addAction(setHeldCallAction)

        requestTransaction(transaction)
    }
}
