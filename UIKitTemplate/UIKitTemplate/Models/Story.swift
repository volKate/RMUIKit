// Story.swift
// Copyright © RoadMap. All rights reserved.

/// Модель истории
struct Story {
    /// Информация об аккаунте
    let account: Account
    /// Статус истории, активная = не просмотренная
    var isActive = false
    /// Принадлежит залогиненному юзеру
    let isOwn: Bool

    init(account: Account, isActive: Bool = false, isOwn: Bool = false) {
        self.account = account
        self.isActive = isActive
        self.isOwn = isOwn
    }
}
