//
//  ColorSchema.swift
//  nReader
//
//  Created by Miter on 2021/10/22.
//

import Foundation
import UIKit

extension UIColor {
    static func fromString(hexString: String) -> UIColor {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count
        let scanner = Scanner(string: hexSanitized)
        
        guard let rgb = scanner.scanInt64(representation: .hexadecimal) else { return UIColor.clear }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return UIColor.red
        }
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}


public struct ColorSchema {
    public var fontColor: UIColor
    public var backColor: UIColor
    
    public init() {
        fontColor = UIColor.fromString(hexString: "#2C2C2C")
        backColor = UIColor.fromString(hexString: "#F0D7AB")
    }
    
    public init(fontColor: UIColor, backColor: UIColor) {
        self.fontColor = fontColor
        self.backColor = backColor
    }
}

extension ColorSchema {
    public static var defaultSchema: ColorSchema {
        get {
            ColorSchema()
        }
    }
}


