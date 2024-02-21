// Array+ActivateContraints.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для быстрой активации массива якорей
extension Array where Element == NSLayoutConstraint {
    func activate() {
        forEach { $0.isActive = true }
    }
}
