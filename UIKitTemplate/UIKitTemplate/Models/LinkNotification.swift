// LinkNotification.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Нотификация
struct LinkNotification {
    let account: Account
    let message: String
    let hoursAgo: Int
    var postThumbnail: String?
    var isSubscribed: Bool = false
}
