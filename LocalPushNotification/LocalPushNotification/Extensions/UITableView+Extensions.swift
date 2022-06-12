//
//  UITableView+Extensions.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 09/06/2022.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type,
                                                        for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell of class \(T.className)")
        }

        return cell
    }
}
