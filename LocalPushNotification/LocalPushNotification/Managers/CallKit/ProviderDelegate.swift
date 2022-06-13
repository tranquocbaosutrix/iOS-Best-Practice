//
//  ProviderDelegate.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 13/06/2022.
//

import CallKit
import AVFoundation

class ProviderDelegate: NSObject {

    /// MARK: Constructor
    private override init() {
        provider = CXProvider(configuration: providerConfiguration)
        super.init()
        provider.setDelegate(self,
                             queue: nil)
    }

    /// MARK: Properties
    static let shared = ProviderDelegate()
    private let provider: CXProvider

    private var providerConfiguration: CXProviderConfiguration = {
        let providerConfiguration = CXProviderConfiguration(localizedName: "BestPractice")
        providerConfiguration.supportsVideo = true
        providerConfiguration.maximumCallsPerCallGroup = 1
        providerConfiguration.supportedHandleTypes = [.phoneNumber]

        return providerConfiguration
    }()

    /// MARK: Functions
    func reportIncomingCall(uuid: UUID,
                            handle: String,
                            hasVideo: Bool = false,
                            completion: ((Error?) -> ())?) {
        //1.
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .phoneNumber, value: handle)
        update.hasVideo = hasVideo

        //2.
        provider.reportNewIncomingCall(with: uuid,
                                       update: update) { error in
            if error == nil {
                //3.
                let call = Call(uuid: uuid, handle: handle)
                CallManager.shared.add(call: call)
            }

            //4.
            completion?(error)
        }
    }
}

/// MARK: Extensions
extension ProviderDelegate: CXProviderDelegate {

    func providerDidReset(_ provider: CXProvider) {
        AudioManager.shared.stopAudio()

        for call in CallManager.shared.calls {
            call.end()
        }

        CallManager.shared.removeAllCalls()
    }

    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        guard let call = CallManager.shared.callWithUUID(uuid: action.callUUID) else {
            action.fail()
            return
        }

        AudioManager.shared.configureAudioSession()

        call.answer()

        action.fulfill()
    }

    func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
        AudioManager.shared.startAudio()
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        guard let call = CallManager.shared.callWithUUID(uuid: action.callUUID) else {
            action.fail()
            return
        }

        AudioManager.shared.stopAudio()

        call.end()

        action.fulfill()

        CallManager.shared.remove(call: call)
    }

}
