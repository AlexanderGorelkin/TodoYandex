//
//  RowSeparatorTrailingPadding.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI

struct RowSeparatorTrailingPadding: ViewModifier {
    func body(content: Content) -> some View {
        content
        .alignmentGuide(.listRowSeparatorTrailing, computeValue: { d in
            d.width
        })
    }
}

extension View {
    func rowSepatatorTrailingPadding() -> some View {
        modifier(RowSeparatorTrailingPadding())
    }
}
