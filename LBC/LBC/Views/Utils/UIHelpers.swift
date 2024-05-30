//
//  UIHelpers.swift
//  LBC
//
//  Created by Khaled on 29/05/2024.
//

import UIKit

enum Constants {
    static let padding: CGFloat = 16.0
    static let topSpacing: CGFloat = 32.0
    static let labelSpacing: CGFloat = 24.0
    static let rowHeight: CGFloat = 160.0
}

public extension UIColor {
    static func random() -> UIColor {
        UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: .random(in: 0...1)
        )
    }
}
