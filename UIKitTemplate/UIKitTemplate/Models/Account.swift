// Account.swift
// Copyright © RoadMap. All rights reserved.

/// Аккаунт юзера
struct Account {
    /// никнейм
    let name: String
    /// имя картинки профиля
    let avatar: String
    /// статистика аккаунта
    private(set) var stats = AccountStats()
    /// Информация об аккаунте
    private(set) var info = AccountInfo()
}
