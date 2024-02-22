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
        let link: String

        init() {
            text = ""
            link = ""
        }

        init(link: String) {
            text = link
            self.link = link
        }

        init(text: String, link: String) {
            self.link = link
            self.text = text
        }
    }
}
