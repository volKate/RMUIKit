// Story.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель истории
struct Story {
    let account: Account
    var isActive = false
    let isOwn: Bool

    init(account: Account, isActive: Bool = false, isOwn: Bool = false) {
        self.account = account
        self.isActive = isActive
        self.isOwn = isOwn
    }
}
