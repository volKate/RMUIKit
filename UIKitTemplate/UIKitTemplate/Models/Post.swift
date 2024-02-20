// Post.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель поста в ленте
struct Post {
    let account: Account
    let postImages: [String]
    let likesCount: Int
    let postDescription: String
}
