//
//  DeleteButton.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI

private let sfSymbolSize: CGFloat = 24

struct DeleteButton: View {
    
    // MARK: - Public Properties
    
    var action: (() -> Void)?
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action?()
        } label: {
            Image(systemName: "trash.fill")
                 .font(.system(size: sfSymbolSize))
                 .foregroundColor(.white)
        }
        .tint(.red)
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton()
    }
}

