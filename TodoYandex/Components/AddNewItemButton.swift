//
//  AddNewItemButton.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI

fileprivate enum LayoutConstants {
    static let sideLenght: CGFloat = 44
    static let imageSize: CGFloat = 22
    static let shadowRadius: CGFloat = 20
    static let shadowX: CGFloat = 0
    static let shadowY: CGFloat = 8
}

struct AddNewItemButton: View {
    
    // MARK: - Public Properties
    
    var action: (() -> Void)?
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action?()
        } label: {
            R.SFSymbols.plus.image
                .font(.system(size: LayoutConstants.imageSize, weight: .bold))
                .foregroundColor(R.Theme.Back.backSecondary.color)
                .frame(
                    width: LayoutConstants.sideLenght ,
                    height: LayoutConstants.sideLenght
                )
                .background(R.Theme.MainColor.blue.color)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .shadow(
            color: R.Theme.Shadow.button.color,
            radius: LayoutConstants.shadowRadius,
            x: LayoutConstants.shadowX,
            y: LayoutConstants.shadowY
        )
    }
}

struct AddNewItemButton_Previews: PreviewProvider {
    static var previews: some View {
        AddNewItemButton()
    }
}

