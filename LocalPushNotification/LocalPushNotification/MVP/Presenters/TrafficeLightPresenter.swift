//
//  TrafficeLightPresenter.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 15/06/2022.
//

import Foundation

protocol TrafficLightViewDelegate: NSObjectProtocol {
    func displayTrafficLight(description: String)
}

class TrafficLightPresenter {
    private let trafficLightService: TrafficLightService
    weak private var trafficLightDelegate: TrafficLightViewDelegate?

    /// MARK: Constructor
    init(trafficLightService: TrafficLightService) {
        self.trafficLightService = trafficLightService
    }

    /// MARK: Functions
    func setViewDelegate(trafficLightViewDelegate: TrafficLightViewDelegate?) {
        self.trafficLightDelegate = trafficLightViewDelegate
    }

    func trafficLightColorSelected(colorName: TrafficLightColor) {
        trafficLightService.getTrafficLight(colorName: colorName) { [weak self] trafficLight in
            if let trafficLight = trafficLight {
                self?.trafficLightDelegate?.displayTrafficLight(description: trafficLight.description)
            }
        }
    }
}
