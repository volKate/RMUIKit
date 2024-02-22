// NSLayoutConstraint+Extension.swift
// Copyright © RoadMap. All rights reserved.

//
//  NSLayoutConstraint+Extension.swift
//  UIKitTemplate
//
//  Created by Kate Volkova on 22.02.24.
//
import UIKit

/// Удобная активация констрейнта
extension NSLayoutConstraint {
    /// Активация одного констрейнта
    func activate() {
        isActive = true
    }
}
