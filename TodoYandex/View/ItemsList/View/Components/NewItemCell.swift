//
//  NewItemCell.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI

fileprivate enum LayoutConstraints {
    static let spacing: CGFloat = 12
    static let spacerWidth: CGFloat = 24
}

struct NewItemCell: View {
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: LayoutConstraints.spacing) {
            Spacer()
                .frame(width: LayoutConstraints.spacerWidth)
            Text("Новое")
                .font(R.AppFont.body.font)
                .foregroundColor(R.Theme.Label.tertiary.color)
            Spacer()
        }
    }
}

struct NewItemCell_Previews: PreviewProvider {
    static var previews: some View {
        NewItemCell()
    }
}
