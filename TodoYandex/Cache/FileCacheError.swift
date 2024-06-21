//
//  FileCacheError.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 21.06.2024.
//

import Foundation
enum FileCacheError: Error {
    case failedToAdd
    case alreadyExists
    case errorToFetchPath
    case failedToLoadItems
    case failedToSave(Error)
    case noElementWithId(String)
    
    var description: String {
        switch self {
        case .failedToAdd:
            "Ошибка добавления"
        case .alreadyExists:
            "Файл с таким id уже создан"
        case .errorToFetchPath:
            "Ошибка в получении пути к папке"
        case .failedToSave(let error):
            "Ошибка при сохрании: \(error.localizedDescription)"
        case .failedToLoadItems:
            "Ошибка при загрузке всех элементов из хранилища"
        case .noElementWithId(let id):
            "Нет элемента с заданным id \(id)"
        }
    }
}
