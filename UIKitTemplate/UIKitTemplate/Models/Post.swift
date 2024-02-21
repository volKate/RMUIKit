// Post.swift
// Copyright © RoadMap. All rights reserved.

/// Модель поста в ленте
struct Post {
    /// Информация об аккаунте
    let account: Account
    /// Имена картинок в посте
    let postImages: [String]
    /// Количество лайков
    let likesCount: Int
    /// Описание
    let postDescription: String
}
