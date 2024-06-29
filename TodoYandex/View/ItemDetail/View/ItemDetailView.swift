//
//  ItemDetailView.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI

fileprivate enum LayoutConstants {
    static let minRowHeight: CGFloat = 56
    static let rectangleCornerRadius: CGFloat = 16
    static let zero: CGFloat = 0
}

struct ItemDetailView: View {
    
    // MARK: - Public Properties
    
    @ObservedObject
    var viewModel: ItemDetailViewModel
    
    // MARK: - Private Properties
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass
    
    @Environment(\.verticalSizeClass)
    private var verticalSizeClass
    
    @FocusState
    private var isFocused: Bool
    
    @State
    private var isDatePickerShowing = false
    
    @State
    private var isColorPickerShowing = false
    
    @State
    private var initialColor: Color = .white
    
    private var inLandscape: Bool {
        horizontalSizeClass == .regular || verticalSizeClass == .compact
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack() {
            content
                .background(R.Theme.Back.backPrimary.color)
                .navigationBarTitle("Дело")
                .scrollDismissesKeyboard(.interactively)
                .navigationBarTitleDisplayMode(.inline)
                .scrollContentBackground(.hidden)
                .toolbar(content: toolBarContent)
        }
    }

    // MARK: - Private Views
    
   @ViewBuilder
   private var content: some View {
        if inLandscape {
            horizontalLayout
        } else {
            verticalLayout
        }
    }
    
   private var horizontalLayout: some View {
        GeometryReader { proxy in
            HStack {
                List {
                    textFieldCell
                        .frame(
                            minHeight: proxy.size.height - proxy.safeAreaInsets.bottom - proxy.safeAreaInsets.top
                        )
                }
                List {
                    Section {
                        importanceCell
                        colorCell
                        deadlineCell
                        if isDatePickerShowing {
                            deadlineDatePicker
                        }
                    }
                    .rowSepatatorTrailingPadding()
                    deleteItemButton
                }
                .frame(
                    maxWidth: isFocused ? LayoutConstants.zero : proxy.size.width
                )
            }
        }
    }
  

    private var verticalLayout: some View {
        List {
            textFieldCell
                Section {
                    importanceCell
                    colorCell
                    deadlineCell
                    if isDatePickerShowing {
                        deadlineDatePicker
                    }
                }
                .rowSepatatorTrailingPadding()
                deleteItemButton
        }
        .environment(\.defaultMinListRowHeight, LayoutConstants.minRowHeight)
    }
    
    private var textFieldCell: some View {
        TextFieldCell(text: $viewModel.text, color: $viewModel.color)
            .listRowBackground(R.Theme.Back.backSecondary.color)
            .focused($isFocused)

    }
    
    private var importanceCell: some View {
        ImportanceCell(importance: $viewModel.importance)
            .listRowBackground(R.Theme.Back.backSecondary.color)
        
    }
    
    private var colorCell: some View {
        ItemColorCell(color: viewModel.color) {
            initialColor = viewModel.color
            isColorPickerShowing = true
        }
        .listRowBackground(R.Theme.Back.backSecondary.color)
        .fullScreenCover(
            isPresented: $isColorPickerShowing,
            content: {
                ItemColorView(color: $viewModel.color, initialColor: $initialColor, hasColor: $viewModel.hasColor)
            }
        )
    }
    
    private var deadlineCell: some View {
        DeadlineCell(
            hasDeadline: $viewModel.hasDeadline,
            deadlineTitle: viewModel.deadline.toString(withFormat: "dd MMMM yyyy"),
            onTap: {
                withAnimation {
                    isDatePickerShowing.toggle()
                }
            })
        .listRowBackground(R.Theme.Back.backSecondary.color)
        .onChange(of: viewModel.hasDeadline) { hasDeadline in
            if !hasDeadline {
                viewModel.deadline = R.Dates.nextDay
                isDatePickerShowing = false
            }
        }
    }
    
    private var deadlineDatePicker: some View {
        DatePicker(
            "Сделать до",
            selection: $viewModel.deadline,
            in: Date()...,
            displayedComponents: [.date]
        )
        .listRowBackground(R.Theme.Back.backSecondary.color)
        .datePickerStyle(.graphical)
    }
    
    private var deleteItemButton: some View {
        HStack {
            Spacer()
            Button("Удалить", action: {
                isFocused = false
                dismiss()
                DispatchQueue.main.async {
                    viewModel.deleteItem()
                }
            })
            .buttonStyle(
                EnabledDisabledButtonStyle(
                    enabledColor: R.Theme.MainColor.red.color,
                    disabledColor: R.Theme.Label.tertiary.color
                )
            )
            .disabled(viewModel.deleteDisabled)
            Spacer()
        }
        .listRowBackground(R.Theme.Back.backSecondary.color)
    }
    
    private var toolBarSaveButton: some View {
        Button("Сохранить") {
            viewModel.addItem()
            isFocused = false
            dismiss()
        }
        .buttonStyle(
            EnabledDisabledButtonStyle(
                enabledColor: R.Theme.MainColor.blue.color,
                disabledColor: R.Theme.Label.tertiary.color
            )
        )
        .disabled(viewModel.saveDisabled)
    }
    
    private var toolBarCancelButton: some View {
        Button("Отменить") {
            dismiss()
        }
    }
    
    // MARK: - Private Methods
    
    @ToolbarContentBuilder
    private func toolBarContent() -> some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            toolBarSaveButton
        }
        ToolbarItem(placement: .cancellationAction) {
            toolBarCancelButton
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(viewModel: ItemDetailViewModel(todoItem: TodoItem.newItem(), fileCache: FileCache()))
    }
}

