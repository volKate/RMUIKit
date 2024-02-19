// UIFont+Verdana.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для шрифта Verdana
extension UIFont {
    static func verdana(ofSize size: CGFloat) -> UIFont? {
        UIFont(name: "Verdana", size: size)
    }

    static func verdanaBold(ofSize size: CGFloat) -> UIFont? {
        UIFont(name: "Verdana-Bold", size: size)
    }
}
