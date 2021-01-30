//
//  Fonts.swift
//  Glade
//
//  Created by Allen Gu on 1/29/21.
//

import Foundation

struct Fonts {
    static let fontName = "HelveticaNeue"
    
    public enum FontType: String {
        case regular = ""
        case bold = "-Bold"
        case medium = "-Medium"
    }
    
    static func getFont(type: FontType, size: CGFloat) -> UIFont {
        return UIFont(name: "\(fontName)\(type.rawValue)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
