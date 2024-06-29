import SwiftUI

@main
struct ToDoListApp: App {
    
    // MARK: - Private Properties
    
    @StateObject
    private var itemsListViewModel = ItemsListViewModel(fileCache: FileCache())
    
    @Environment(\.scenePhase)
    private var scenePhase
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            ItemsListView()
                .environmentObject(itemsListViewModel)
                .onAppear {
                    itemsListViewModel.loadItems()
                }
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive {
                        itemsListViewModel.saveItems()
                    }
                }
        }
    }
}
