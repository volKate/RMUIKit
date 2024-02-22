// LinkNotification.swift
// Copyright © RoadMap. All rights reserved.

/// Нотификация
struct LinkNotification {
    /// Тип нотификации
    enum NotificationType {
        /// с кнопкой подписаться
        case subscribe
        /// со ссылкой на пост
        case post
    }

    /// Информация об аккаунте
    let account: Account
    /// Сообщение
    let message: String
    /// Как давно опубликовано
    let hoursAgo: Int
    /// Тип нотификации
    let type: NotificationType
    /// Имя картинки поста
    var postThumbnail: String?
    /// Подписан ли текущий юзер на аккаунт в нотификации
    var isSubscribed: Bool = false

    init(account: Account, message: String, hoursAgo: Int, postThumbnail: String) {
        self.account = account
        self.message = message
        self.hoursAgo = hoursAgo
        self.postThumbnail = postThumbnail
        type = .post
    }

    init(account: Account, message: String, hoursAgo: Int, isSubscribed: Bool) {
        self.account = account
        self.message = message
        self.hoursAgo = hoursAgo
        self.isSubscribed = isSubscribed
        type = .subscribe
    }
}
