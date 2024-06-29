//
//  Date+Extensions.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import Foundation
extension Date {
    func toString(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let string = dateFormatter.string(from: self)
        return string
    }
}
