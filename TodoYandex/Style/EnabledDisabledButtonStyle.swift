//
//  EnabledDisabledButtonStyle.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI

struct EnabledDisabledButtonStyle: ButtonStyle {
    
    // MARK: - Public Properties
    
    let enabledColor: Color
    let disabledColor: Color
    
    // MARK: - Private Properties
    
    @Environment(\.isEnabled)
    private var isEnabled
    
    // MARK: - Public Methods
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isEnabled ? enabledColor : disabledColor)
    }
}
