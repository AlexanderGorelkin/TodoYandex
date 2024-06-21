//
//  String+Extensions.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 21.06.2024.
//

import Foundation
extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: self)
        return date
    }
}
