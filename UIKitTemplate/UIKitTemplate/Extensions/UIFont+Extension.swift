// UIFont+Verdana.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для шрифта Verdana
extension UIFont {
    /// Шрифт вердана с жирностью 400
    static func verdana(ofSize size: CGFloat) -> UIFont? {
        UIFont(name: "Verdana", size: size)
    }

    /// Шрифт вердана с жирностью 700
    static func verdanaBold(ofSize size: CGFloat) -> UIFont? {
        UIFont(name: "Verdana-Bold", size: size)
    }
}
