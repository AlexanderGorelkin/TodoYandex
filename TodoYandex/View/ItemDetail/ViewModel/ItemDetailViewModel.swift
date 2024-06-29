//
//  ItemDetailViewModel.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI
import Combine

class ItemDetailViewModel: ObservableObject {
    
    // MARK: - ToDoType
    
    enum TodoType {
        case new
        case existed
    }
    
    // MARK: - Public Properties
    
    let id: String
    var isDone: Bool
    let createdAt: Date
    var modificationDate: Date?
    let todoType: TodoType
    var hasColor: Bool
    
    var deleteDisabled: Bool {
        return todoType == .new ? true : false
    }
    
    var saveDisabled: Bool {
        text.isEmpty
    }
    
    var initialColor: Color {
        return color
    }
    
    @Published
    var text: String
    
    @Published
    var importance: Importance
    
    @Published
    var hasDeadline: Bool
    
    @Published
    var deadline: Date
    
    @Published
    var color: Color
    
    // MARK: - Private Properties
    
    private let fileCache: FileCache
    
    // MARK: - Init
    
    init(todoItem: TodoItem, fileCache: FileCache) {
        self.id = todoItem.id
        self.text = todoItem.text
        self.isDone = todoItem.isDone
        self.importance = todoItem.importance
        self.hasDeadline = todoItem.deadline == nil ? false : true
        self.deadline = todoItem.deadline ?? R.Dates.nextDay
        self.createdAt = todoItem.createdAt
        self.fileCache = fileCache
        self.todoType = todoItem.text.isEmpty ? .new : .existed
        self.hasColor = todoItem.hexColor == nil ? false : true
        self.color = Color(hex: todoItem.hexColor ?? "FFFFFF")
    }
    
    // MARK: - Public Methods
    
    func addItem() {
        var currentDeadline: Date?
        
        if !hasDeadline {
            currentDeadline = nil
        } else {
            currentDeadline = deadline
        }
        let item = TodoItem(
            id: id,
            text: text.trimmingCharacters(in: .whitespacesAndNewlines),
            isDone: isDone,
            createdAt: createdAt,
            importance: importance,
            deadline: deadline,
            updatedAt: todoType == .new ? nil : Date(),
            hexColor:  hasColor ? color.hexString : nil
        )
        do {
            try fileCache.addItem(new: item)
        } catch {
            
        }
        
    }
    
    func deleteItem() {
        do {
            try fileCache.removeItem(with: id)
        } catch {
            
        }
    }
}


