//
//  ItemColorCell.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI

struct ItemColorCell: View {
    
    // MARK: - Private Properties
    
    var color: Color?
    var onTap: (() -> Void)?
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Text("Цвет")
                .font(R.AppFont.body.font)
            Spacer()
            GradientRing(color: color ?? .white, size: .small)
                .onTapGesture {
                    onTap?()
                }
        }
    }
}

struct ItemColorCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemColorCell(color: .green)
    }
}
