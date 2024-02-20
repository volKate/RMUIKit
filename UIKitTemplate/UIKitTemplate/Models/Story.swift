// Story.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель истории
struct Story {
    let avatar: String
    let accountName: String
    var isActive = false
    let isOwn: Bool

    init(avatar: String, accountName: String, isActive: Bool = false, isOwn: Bool = false) {
        self.avatar = avatar
        self.accountName = accountName
        self.isActive = isActive
        self.isOwn = isOwn
    }
}
