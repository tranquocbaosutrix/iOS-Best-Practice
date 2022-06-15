//
//  TrafficLight.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 15/06/2022.
//

import Foundation

enum TrafficLightColor {
    case red, green, yellow
}

struct TrafficLight {
    let colorName: TrafficLightColor
    let description: String
}
