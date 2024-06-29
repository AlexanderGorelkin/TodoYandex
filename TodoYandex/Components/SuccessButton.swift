//
//  SuccessButton.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI

private let sfSymbolSize: CGFloat = 24

struct SuccessButton: View {
    
    // MARK: - Public Properties
    
    var action: (() -> Void)?
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action?()
        } label: {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: sfSymbolSize))
                .foregroundColor(Color.white)
        }
        .tint(R.Theme.MainColor.green.color)
    }
}

struct SuccessButton_Previews: PreviewProvider {
    static var previews: some View {
        SuccessButton()
    }
}
