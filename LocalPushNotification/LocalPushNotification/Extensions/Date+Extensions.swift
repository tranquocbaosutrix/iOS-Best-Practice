//
//  Date+Extensions.swift
//  LocalPushNotification
//
//  Created by TranQuocBao on 12/06/2022.
//

import Foundation

enum DateFormatType: String {
    /// dd/MM/yyyy
    case type1 = "dd/MM/yyyy"

    /// dd/MM/yyyy hh:mm:ss
    case type2 = "dd/MM/yyyy hh:mm:ss"

    /// dd/MM/yyyy HH:mm:ss (24 hours format)
    case type3 = "dd/MM/yyyy HH:mm:ss"
}

extension Date {
    func formattedDate(_ dateFormat: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: self)
    }
}
