//
//  TodoItem.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 21.06.2024.
//

import Foundation

enum Importance: String, CaseIterable {
    case low = "Неважная"
    case normal = "Обычная"
    case high = "Важная"
}

/// Иммутабельная структура TodoItem
struct TodoItem: Equatable {
    /// Уникальный идентификатор
    var id: String
    /// Строковое поле
    var text: String
    /// Флаг того, что задача сделана
    var isDone: Bool
    /// Дата создания задачи
    var createdAt: Date
    /// Поле важность
    var importance: Importance
    /// Дедлайн
    var deadline: Date?
    /// Дата изменения
    var updatedAt: Date?
    
    init(
        id: String = UUID().uuidString,
        text: String,
        isDone: Bool = false,
        createdAt: Date = Date(),
        importance: Importance = .normal,
        deadline: Date? = nil,
        updatedAt: Date? = nil
    ) {
        self.id = id
        self.text = text
        self.isDone = isDone
        self.createdAt = createdAt
        self.importance = importance
        self.deadline = deadline
        self.updatedAt = updatedAt
    }
}
// MARK: JSON конвертеры
extension TodoItem {
    static func parse(json: Any) -> TodoItem? {
        guard let json = json as? [String: Any] else { return nil }
        guard let id = json["id"] as? String,
              let text = json["text"] as? String,
              let isDone = json["isDone"] as? Bool,
              let createdAt = (json["createdAt"] as? String)?.toDate()
        else { return nil }
        let importance = (json["importance"] as? String).flatMap(Importance.init(rawValue:)) ?? .normal
        let deadline = (json["deadline"] as? String)?.toDate()
        let updatedAt = (json["updatedAt"] as? String)?.toDate()
        
        return .init(
            id: id,
            text: text,
            isDone: isDone,
            createdAt: createdAt,
            importance: importance,
            deadline: deadline,
            updatedAt: updatedAt
        )
    }
    var json: Any {
        var dictionary: [String: Any] = [
            "id": id,
            "text": text,
            "isDone": isDone,
            "createdAt": createdAt
        ]
        
        if importance != .normal {
            dictionary["importance"] = importance.rawValue
        }
        
        if let deadline = deadline {
            dictionary["deadline"] = deadline
        }
        return dictionary
    }
}
extension TodoItem {
    static func parse(csv: String) -> [TodoItem?] {
        var todoItems = [TodoItem?]()
        let lines = csv.components(separatedBy: "\n")
        
        for line in lines {
            let lineComponents = line.components(separatedBy: ",")
            let id = lineComponents[0]
            let text = lineComponents[1]
            let isDone = NSString(string: lineComponents[2]).boolValue
            let createdAt = lineComponents[3].toDate() ?? Date()
            let importance = Importance(rawValue: lineComponents[4]) ?? .normal
            let deadline = lineComponents[5].toDate()
            let updatedAt = lineComponents[6].toDate()
            todoItems.append(
                .init(
                    id: id,
                    text: text,
                    isDone: isDone,
                    createdAt: createdAt,
                    importance: importance,
                    deadline: deadline,
                    updatedAt: updatedAt
                )
            )
        }
        return todoItems
    }
}
