//
//  ColorPalette.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 11/01/22.
//

import Foundation
import UIKit

struct ColorPalette {
    static var background: UIColor { ColorType.background.color }
    static var text: UIColor { ColorType.text.color }
}

enum ColorType {
    case background
    case text

    var color: UIColor {
        let color = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            switch traitCollection.userInterfaceStyle {
            case .unspecified, .light:
                return UIColor(hex: self.hexadecimalLightMode)
            case .dark:
                return UIColor(hex: self.hexadecimalDarkMode)
            @unknown default:
                assertionFailure("UserInterfaceStyle")
                return UIColor(hex: self.hexadecimalLightMode)
            }
        }
        return color
    }

    private var hexadecimalLightMode: String {
        switch self {
            case .background: return "#FFFFFF"
            case .text: return "#222222"
        }
    }

    private var hexadecimalDarkMode: String {
        switch self {
            case .background: return "#222222"
            case .text: return "#FFFFFF"
        }
    }
}
