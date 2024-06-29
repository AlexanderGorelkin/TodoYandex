//
//  ItemsListView.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI

fileprivate enum LayoutConstants {
    static let minRowHeight: CGFloat = 56
    static let addNewItemButonPadding: CGFloat = 20
}

struct ItemsListView: View {
    
    // MARK: - Public Properties
    
    @EnvironmentObject
    var vm: ItemsListViewModel
    
    // MARK: - Private Properties
    
    @State
    private var selectedItem: TodoItem? = nil
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                itemsList
                addNewItemButton
            }
        }
    }
    
    // MARK: - Private Views
    
    private var itemsList: some View {
        List {
            Section {
                ForEach($vm.TodoItems) { $TodoItem in
                    ItemCell(
                        todoItem: TodoItem,
                        onButtonTap: {
                        vm.toggleIsDone(for: TodoItem)
                    })
                    .listRowBackground(R.Theme.Back.backSecondary.color)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.selectedItem = TodoItem
                    }
                    .swipeActions(edge: .leading) {
                        SuccessButton {
                            vm.toggleIsDone(for: TodoItem)
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        DeleteButton {
                            vm.deleteItem(TodoItem)
                        }
                        InfoButton {
                            print(TodoItem.text)
                        }
                    }
                }
                newItemCell
            } header: {
                listHeaderView
            }
            .textCase(nil)
            .rowSepatatorLeadingPadding()
        }
        .sheet(item: $selectedItem,
               content: { item in
            ItemDetailView(
                viewModel: ItemDetailViewModel(
                    todoItem: item,
                    fileCache: vm.fileCache
                )
            )
        })
        .scrollContentBackground(.hidden)
        .background(R.Theme.Back.backPrimary.color)
        .navigationTitle("Мои дела")
        .environment(\.defaultMinListRowHeight, LayoutConstants.minRowHeight)
    }
    
    private var newItemCell: some View {
        NewItemCell()
            .contentShape(Rectangle())
            .onTapGesture {
                self.selectedItem = TodoItem.newItem()
            }
            .listRowBackground(R.Theme.Back.backSecondary.color)
    }
    
    private var listHeaderView: some View {
        ListHeaderView(
            sortOption: $vm.sortOption,
            filterOption: $vm.filterOption,
            isDoneCount: vm.isDoneCount
        )
    }
    
    private var addNewItemButton: some View {
        AddNewItemButton {
            selectedItem = TodoItem.newItem()
        }
        .padding(LayoutConstants.addNewItemButonPadding)
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsListView()
            .environmentObject(ItemsListViewModel(fileCache: FileCache()))
    }
}

