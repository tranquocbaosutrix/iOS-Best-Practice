//
//  CallKitViewModel.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 12/06/2022.
//

final class CallKitViewModel {

    /// MARK: Constructor
    init() {
        CallManager.shared.callsChangedHandler = { [weak self] in
            self?.reloadCallTableView?()
        }
    }

    /// MARK: Properties
    var reloadCallTableView: (() -> ())?

    var makeNewCall: ((String) -> ())?

    var callCount: Int {
        get {
            return CallManager.shared.calls.count
        }
    }

    /// MARK: Functions
    private final func call(at index: Int) -> Call {
        return CallManager.shared.calls[index]
    }

    final func checkPhoneInput(_ phone: String?) {
//        if let phone = phone,
//            !phone.isEmpty,
//            Utils.isValidPhone(phone: phone) {
//            makeNewCall?(phone)
//        } else {
//            makeNewCall?("Anonymous Call...")
//        }

        if let phone = phone,
            !phone.isEmpty {
            makeNewCall?(phone)
        } else {
            makeNewCall?("Anonymous Call...")
        }
    }

    final func callName(at index: Int) -> String {
        let call = CallManager.shared.calls[index]
        return "\(call.outgoing ? "Outgoing Call: " : "Incoming Call: ") \(call.handle)"
    }

    final func callStatus(at index: Int) -> String {
        let call = call(at: index)

        switch call.state {
        case .connecting:
            return "Connecting..."
        case .held:
            return "On Hold"
        case .active:
            return "Active"
        default:
            return "Dialing..."
        }
    }

    final func endCall(at index: Int) {
        CallManager.shared.end(call: call(at: index))
    }

    final func holdCall(at index: Int) {
        let call = call(at: index)
        call.state = call.state == .held ? .active : .held
        CallManager.shared.setHeld(call: call, onHold: call.state == .held)
    }

    final func makeOutgoingCall() {
        ProviderDelegate.shared.startCall(handle: "1111", videoEnabled: false)
    }
}
