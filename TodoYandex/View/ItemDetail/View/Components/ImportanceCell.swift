//
//  ImportanceCell.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI

private let hStackSpacing: CGFloat = 16

struct ImportanceCell: View {
    
    // MARK: - Public Properties
    
    @Binding
    var importance: Importance
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: hStackSpacing) {
            Text("Важность")
                .font(R.AppFont.body.font)
                .frame(maxWidth: .infinity, alignment: .leading)
            ImportancePicker(importance: $importance)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct ImportanceCell_Previews: PreviewProvider {
    static var previews: some View {
        ImportanceCell(importance: .constant(.normal))
    }
}
