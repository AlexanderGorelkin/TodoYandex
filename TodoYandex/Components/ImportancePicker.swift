//
//  ImportancePicker.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI

struct ImportancePicker: View {
    
    // MARK: - Public Properties
    
    @Binding
    var importance: Importance
    
    // MARK: - Body
    
    var body: some View {
        Picker(importance.title, selection: $importance) {
            Text(Importance.low.title)
                .tag(Importance.low)
            Text(Importance.normal.title)
                .tag(Importance.normal)
            Text(Importance.high.title)
                .tag(Importance.high)
        }
        .pickerStyle(.segmented)
    }
}

struct ImportancePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImportancePicker(importance: .constant(.normal))
    }
}

