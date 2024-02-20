// Post.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель поста в ленте
struct Post {
    let avatar: String
    let accountName: String
    let postImages: [String]
    let likesCount: Int
    let postDescription: String
}
