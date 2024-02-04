//
//  TypeColor.swift
//  Pokedex
//
//  Created by Nimrod Borochov on 04/02/2024.
//

import SwiftUI

enum `Type` : String, Codable, Equatable {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case unknown
    case shadow

    func color() -> UIColor {
        var hex = ""

        switch self {
        case .normal:
            hex = "#A8A77A"
        case .fighting:
            hex = "#C22E28"
        case .flying:
            hex = "#A98FF3"
        case .poison:
            hex = "#A33EA1"
        case .ground:
            hex = "#E2BF65"
        case .rock:
            hex = "#B6A136"
        case .bug:
            hex = "#A6B91A"
        case .ghost:
            hex = "#735797"
        case .steel:
            hex = "#B7B7CE"
        case .fire:
            hex = "#EE8130"
        case .water:
            hex = "#6390F0"
        case .grass:
            hex = "#7AC74C"
        case .electric:
            hex = "#F7D02C"
        case .psychic:
            hex = "#F95587"
        case .ice:
            hex = "#96D9D6"
        case .dragon:
            hex = "#6F35FC"
        case .dark:
            hex = "#705746"
        case .fairy:
            hex = "#D685AD"
        case .unknown:
            hex = "#ffffff00"
        case .shadow:
            hex = "#a0ff7a"
        }

        return UIColor(hex: hex) ?? UIColor(.clear)
    }

    func textColorOnBg() -> Color {
        switch self {

        case .normal, .flying, .ground, .rock, .bug, .steel, .grass, .electric, .ice, .fairy, .shadow:
            return .black
        case .fighting, .poison, .ghost, .fire, .water, .psychic, .dragon, .dark:
            return .white
        case .unknown:
            return .primary
        }
    }
}

extension UIColor {

    // MARK: - Initialization

    convenience init?(hex: String) {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if hexColor.count == 6, scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
                g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
                b = CGFloat(hexNumber & 0x0000FF) / 255.0

                self.init(red: r, green: g, blue: b, alpha: a)
                return
            } else if hexColor.count == 8, scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255

                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }

        }
        return nil
    }


}
