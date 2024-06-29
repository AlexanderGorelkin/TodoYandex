//
//  ItemsListViewModel.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import Combine

typealias FilterOption = ItemsListViewModel.FilterOption
typealias SortOption = ItemsListViewModel.SortOption

class ItemsListViewModel: ObservableObject {
    
    // MARK: - FilterOptions
    
    enum FilterOption: String, CaseIterable, Identifiable {
        case all
        case notDone
        
        var id: Self { return self }
    }
    
    // MARK: - SortOptions
    
    enum SortOption: String, CaseIterable, Identifiable {
        case creationDate
        case importance
        
        var id: Self { return self }
    }
    
    // MARK: - Public Properties
    
    @Published
    var TodoItems: [TodoItem] = []
    
    @Published
    var filterOption: FilterOption = .notDone
    
    @Published
    var sortOption: SortOption = .creationDate
    
    let fileCache: FileCache
    
    var isDoneCount: Int {
        return fileCache.todoItems.lazy.filter({ $0.isDone }).count
    }
    
    // MARK: - Private Properties
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(fileCache: FileCache) {
        self.fileCache = fileCache
        bind()
    }
    
    // MARK: - Public Methods
    
    func addItem(_ item: TodoItem) {
        do {
            try fileCache.addItem(new: item)
        } catch {
            
        }
    }
    
    func deleteItem(_ item: TodoItem)  {
        do {
            try fileCache.removeItem(with: item.id)
        } catch {
            
        }
    }
    
    func saveItems()  {
        do {
            try fileCache.saveItems()
        } catch {
            
        }
    }
    
    func loadItems()  {
        do {
            try fileCache.loadAllItems()
        } catch {
            
        }
    }
    
    func toggleIsDone(for item: TodoItem) {
        let newItem = TodoItem(
            id: item.id,
            text: item.text,
            isDone: !item.isDone,
            createdAt: item.createdAt,
            importance: item.importance,
            deadline: item.deadline,
            updatedAt: item.updatedAt,
            hexColor: item.hexColor
        )
        addItem(newItem)
    }
    
    // MARK: - Private Methods
    
    private func bind() {
        fileCache.$todoItems.combineLatest($filterOption, $sortOption)
            .eraseToAnyPublisher()
            .sink { [weak self] items, filterOption, sortOption in
                guard let self else { return }
                self.TodoItems = self.filter(items,with: filterOption)
                self.TodoItems = self.sort(self.TodoItems, with: sortOption)
            }
            .store(in: &cancellables)
    }
    
    
    private func filter(_ items: [TodoItem], with filterOption: FilterOption) -> [TodoItem] {
        switch filterOption {
        case .all:
            return items
        case .notDone:
            return items.filter { !$0.isDone }
        }
    }
    
    private func sort(_ items: [TodoItem], with sortOption: SortOption) -> [TodoItem] {
        switch sortOption {
        case .creationDate:
            return items.sorted { $0.createdAt < $1.createdAt }
            //            return items.sorted { $0.creationDate < $1.creationDate }
        case .importance:
            return items.sorted { $0.importance.rawValue > $1.importance.rawValue }
        }
    }
}

// MARK: - ItemsListViewModel.FilterOption

extension ItemsListViewModel.FilterOption {
    var title: String {
        switch self {
        case .all:
            return "Показать"
        case .notDone:
            return "Скрыть"
        }
    }
}

// MARK: - ItemsListViewModel.SortOption

extension ItemsListViewModel.SortOption {
    var title: String {
        switch self {
        case .creationDate:
            return "Добавлению"
        case .importance:
            return "Важности"
        }
    }
}
