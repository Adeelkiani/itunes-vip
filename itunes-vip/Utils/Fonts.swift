//
//  Fonts.swift
//  Itunesvip
//
//  Created by Adeel kiani on 02/09/2022.
//

import Foundation
import UIKit

enum FontFamily: String {
    case book = "Avenir-Book"
    case light = "Avenir-Light"
    case bold = "Avenir-Heavy"
}

class Fonts {
    private static let fontFamily = [
        "Bold": FontFamily.bold.rawValue,
        "Light": FontFamily.light.rawValue,
        "Book": FontFamily.book.rawValue
    ]
    
    static func font(fontWeight: FontFamily = .book, fontSize: CGFloat) -> UIFont {
        return UIFont(name: fontWeight.rawValue, size: fontSize) ?? defaultFont(fontSize: fontSize)
    }
    
    static func font(type: String = "Book", fontSize: CGFloat) -> UIFont {
        
        let fontFamily = fontFamily[type] ?? type
        return UIFont(name: fontFamily, size: fontSize) ?? defaultFont(fontSize: fontSize)
    }

    private static func defaultFont(fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize)
    }
}
