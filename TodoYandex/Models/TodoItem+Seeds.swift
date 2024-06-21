//
//  TodoItem+Seeds.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 21.06.2024.
//

import Foundation
extension TodoItem {
    enum Seeds {
        static let model = TodoItem(
            id: "1111",
            text: "Hello World!",
            isDone: false,
            createdAt: "2015-04-01T11:42:00".toDate()!,
            importance: .high,
            deadline: nil,
            updatedAt: nil
        )
        static let csvString = "1111,Hello World!,false,2015-04-01T11:42:00,Важная, , "
        static let jsonFormat: [String: Any] = [
            "id": "1111",
            "text": "Hello World!",
            "isDone": false,
            "createdAt": "2015-04-01T11:42:00".toDate()!,
            "importance": "Важная",
        ]
    }
}

