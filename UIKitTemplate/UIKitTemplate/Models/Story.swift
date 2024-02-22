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
    /// Изображение в истории
    var imageName: String
    /// Имя актуальной истории
    var highlightName: String = ""

    init(
        account: Account,
        imageName: String,
        isActive: Bool = false,
        isOwn: Bool = false,
        highlightName: String = ""
    ) {
        self.account = account
        self.imageName = imageName
        self.isActive = isActive
        self.isOwn = isOwn
        self.highlightName = highlightName
    }
}
