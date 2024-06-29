//
//  DeadlineCell.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI

struct DeadlineCell: View {
    
    // MARK: - Public Properties
    
    @Binding
    var hasDeadline: Bool
    
    var deadlineTitle: String
    var onTap: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Toggle(isOn: $hasDeadline) {
            VStack(alignment: .leading) {
                deadlineText
                if hasDeadline {
                    deadlineButton
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Private Views
    
    private var deadlineText: some View {
        Text("Сделать до")
    }
    
    private var deadlineButton: some View {
        Button {
            onTap()
        } label: {
            Text(deadlineTitle)
                .font(R.AppFont.subheadBold13.font)
        }
        .foregroundColor(R.Theme.MainColor.blue.color)
    }
}

struct DeadlineCell_Previews: PreviewProvider {
    static var previews: some View {
        DeadlineCell(hasDeadline: .constant(true),deadlineTitle: "aaa" , onTap: {})
    }
}

