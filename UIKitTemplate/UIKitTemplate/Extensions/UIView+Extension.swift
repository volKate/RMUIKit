// UIView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Удобное отключение ресайз маски
extension UIView {
    /// Отключение ресайз маски у вью
    func disableAutoresizingMask() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
