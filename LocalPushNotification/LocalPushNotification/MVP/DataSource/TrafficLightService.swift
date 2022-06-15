//
//  TrafficLightService.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 15/06/2022.
//

import Foundation

class TrafficLightService {

    func getTrafficLight(colorName: TrafficLightColor, callBack: (TrafficLight?) -> ()) {
        let trafficLights = [TrafficLight(colorName: .red,
                                          description: "Stop"),
                             TrafficLight(colorName: .green,
                                          description: "Go"),
                             TrafficLight(colorName: .yellow,
                                          description: "About to change to red")]

        if let foundTrafficLight = trafficLights.first(where: { $0.colorName == colorName }) {
            callBack(foundTrafficLight)
        } else {
            callBack(nil)
        }
    }

}
