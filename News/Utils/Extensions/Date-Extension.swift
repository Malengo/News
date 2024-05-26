//
//  Date-Extension.swift
//  News
//
//  Created by Malengo on 26/05/24.
//

import Foundation

extension Date {
    func formatedDate(formated: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: formated)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date ?? Date.now)
    }
}
