//
//  Resources.swift
//  TodoYandex
//
//  Created by Александр Горелкин on 29.06.2024.
//

import SwiftUI
enum R {
    
    enum Theme {
        
        enum Support: String {
            case separator
            case overlay
            case navBarBlur
            
            var color: Color {
                Color(rawValue)
            }
        }
        
        enum Label: String {
            case labelPrimary
            case labelSecondary
            case tertiary
            case disable
            
            var color: Color {
                Color(rawValue)
            }
        }
        
        enum MainColor: String {
            case red
            case green
            case blue
            case gray
            case grayLight
            case white
            
            var color: Color {
                Color(rawValue)
            }
        }
        
        enum Back: String {
            case iosPrimary
            case backPrimary
            case backSecondary
            case elevated
            
            var color: Color {
                Color(rawValue)
            }
        }
        
        enum Shadow: String {
            case button
            
            var color: Color {
                Color(rawValue)
            }
        }
    }
    enum AppFont {
        case largeTitle
        case title
        case headline
        case body
        case subhead
        case subheadBold
        case subheadBold13
        case footnote
        
        var font: Font {
            switch self {
            case .largeTitle:
                return Font.system(size: 38, weight: .bold)
            case .title:
                return Font.system(size: 20, weight: .semibold)
            case .headline:
                return Font.system(size: 17, weight: .semibold)
            case .body:
                return Font.system(size: 17, weight: .regular)
            case .subhead:
                return Font.system(size: 15, weight: .regular)
            case .subheadBold:
                return Font.system(size: 15, weight: .bold)
            case .subheadBold13:
                return Font.system(size: 13, weight: .bold)
            case .footnote:
                return Font.system(size: 13, weight: .semibold)
            }
        }
    }
    enum Dates {
        static let nextDay = Date().addingTimeInterval(60 * 60 * 24)
    }
    enum Images: String {
        case importanceLow
        case importanceHigh
        case priorityRegular
        case priorityHigh
        case success
        case chevron
        
        var image: Image {
           Image(rawValue)
        }
    }
    enum SFSymbols: String {
        case calendar
        case circle
        case plus
        case checkmark
        case checkmarkCircleFill = "checkmark.circle.fill"
        case infoCircleFill = "info.circle.fill"
        case trashFill = "trash.fill"
        
        var image: Image {
            return Image(systemName: rawValue)
        }

    }
}
