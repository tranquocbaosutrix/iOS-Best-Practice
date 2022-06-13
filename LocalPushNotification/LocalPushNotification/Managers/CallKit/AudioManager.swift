//
//  AudioManager.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 13/06/2022.
//

import AVFoundation

class AudioManager {

    /// MARK: Constructor
    private init() {}

    /// MARK: Properties
    static let shared = AudioManager()

    /// MARK: Functions
    func configureAudioSession() {
        let session = AVAudioSession.sharedInstance()

        do {
            try session.setCategory(.playAndRecord,
                                    mode: .voiceChat,
                                    options: [])
        } catch (let error) {
            print("Configuring audio session failed with: \(error.localizedDescription)")
        }
    }

    func startAudio() {
        print("Starting audio")
    }

    func stopAudio() {
        print("Stopping audio")
    }

}
