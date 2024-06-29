//
//  FileCache.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 21.06.2024.
//

import Foundation

final class FileCache {
    @Published private(set) var todoItems: [TodoItem] = []
    private let filesPath: String = "TodoItems"
    private let filesExtension: String = "json"
    
    
    func addItem(new item: TodoItem) throws {
        if !todoItems.contains(where: { $0.id == item.id }) {
            todoItems.append(item)
        } else if let index = todoItems.firstIndex(where: { $0.id == item.id }){
            todoItems[index] = item
        } else {
            throw FileCacheError.failedToAdd
        }
    }
    
    func removeItem(with id: String) throws {
        if let index = todoItems.firstIndex(where: { $0.id == id }) {
            todoItems.remove(at: index)
        } else {
            throw FileCacheError.noElementWithId(id)
        }
    }
    
    func saveItems() throws {
        let todoItemsStorageURL = try createBaseURL()
        
        let jsonArray = todoItems.map { $0.json }
        let data = try JSONSerialization.data(withJSONObject: jsonArray,  options: [])
        do {
            try data.write(to: todoItemsStorageURL)
        } catch {
            throw FileCacheError.failedToSave(error)
        }
    }
    
    func loadAllItems() throws {
        let todoItemsStorageURL = try createBaseURL()
        let data = try Data(contentsOf: todoItemsStorageURL)
        if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [Any] {
            todoItems = jsonObject.compactMap(TodoItem.parse)
        } else {
            throw FileCacheError.failedToLoadItems
        }
    }
    
    private func createBaseURL() throws -> URL {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { throw FileCacheError.errorToFetchPath }
        return documentDirectory.appendingPathComponent(filesPath).appendingPathExtension(filesExtension)
    }
}


