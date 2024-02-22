// Array+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для быстрой активации массива якорей
extension Array where Element == NSLayoutConstraint {
    /// Активация всех якорей
    func activate() {
        forEach { $0.isActive = true }
    }
}
