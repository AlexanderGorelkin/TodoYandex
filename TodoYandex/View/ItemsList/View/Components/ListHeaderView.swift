//
//  ListHeaderView.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI

struct ListHeaderView: View {
    
    // MARK: - Public Properties
    
    @Binding
    var sortOption: SortOption
    
    @Binding
    var filterOption: FilterOption
    
    var isDoneCount: Int
    
    // MARK: - Private Properties
    
    private var isDoneTitle: String {
        return "Выполнено - " + "\(isDoneCount)"
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            isDoneText
            Spacer()
            sortFilterMenu
        }
        .background(R.Theme.Back.backPrimary.color)
    }
    
    // MARK: - Private Views
    
    private var isDoneText: some View {
      Text(isDoneTitle)
            .font(R.AppFont.subhead.font)
            .foregroundColor(R.Theme.Label.tertiary.color)
    }
    
    private var menuTitle: some View {
        Text("Фильтр")
            .font(R.AppFont.subheadBold.font)
            .foregroundColor(R.Theme.MainColor.blue.color)
    }
    
    private var sortFilterMenu: some View {
        Menu(content: {
            isDoneSection
            importanceSection
        },
             label: {
            menuTitle
        })
    }
    
    private var importanceSection: some View {
        Section("Сортировать по") {
            ForEach(SortOption.allCases) { option in
                Button {
                    sortOption = option
                } label: {
                    if sortOption == option {
                        Image(systemName: "checkmark")
                    }
                    Text(option.title)
                }
            }
        }
    }
    
    private var isDoneSection: some View {
        Section("Выполненные") {
            ForEach(FilterOption.allCases) { option in
                Button {
                    filterOption = option
                } label: {
                    if filterOption == option {
                        Image(systemName: "checkmark")
                    }
                    Text(option.title)
                }
                
            }
        }
    }
}

struct ListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderView(sortOption: .constant(.importance), filterOption: .constant(.all), isDoneCount: 4)
    }
}

