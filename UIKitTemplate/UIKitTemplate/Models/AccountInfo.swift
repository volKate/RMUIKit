// AccountInfo.swift
// Copyright © RoadMap. All rights reserved.

/// Информация об аккаунте
struct AccountInfo {
    /// Полное имя
    private(set) var fullName = ""
    /// Описание профиля
    private(set) var description = ""
    /// Сыллка в профиле
    private(set) var link = Link()

    /// Ссылка
    struct Link {
        /// Текст ссылки
        let text: String
        /// Url ссылки
        let url: String

        init(url: String = "") {
            text = url
            self.url = url
        }

        init(text: String, url: String) {
            self.url = url
            self.text = text
        }
    }
}
