//
//  MainCollectionViewModel.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 09/07/2022.
//

import UIKit

final class MainCollectionViewModel {

    /// MARK: Properties
    private var colors = [UIColor.red, UIColor.green, UIColor.blue,
                UIColor.green, UIColor.purple, UIColor.orange,
                UIColor.blue, UIColor.green, UIColor.blue,
                UIColor.green, UIColor.red, UIColor.green,
                UIColor.blue, UIColor.green, UIColor.purple,
                UIColor.orange, UIColor.blue, UIColor.green,
                UIColor.blue, UIColor.green, UIColor.red,
                UIColor.green, UIColor.blue, UIColor.green,
                UIColor.purple, UIColor.orange, UIColor.blue,
                UIColor.green, UIColor.blue, UIColor.green,
                UIColor.red, UIColor.green, UIColor.blue,
                UIColor.green, UIColor.purple, UIColor.orange,
                UIColor.blue, UIColor.green, UIColor.blue,
                UIColor.green
    ]

    /// MARK: Functions
    final func listOfColors() -> [UIColor] {
        return colors
    }

    final func colorItem(at index: Int) -> UIColor {
        return colors[index]
    }

}
