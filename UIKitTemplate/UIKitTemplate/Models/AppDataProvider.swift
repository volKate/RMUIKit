// AppDataProvider.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные для ленты
struct AppDataProvider {
    static let shared = AppDataProvider()
    let currentUserAvatar = "rm_ka"
    private let stories = [
        Story(avatar: "rm_ka", accountName: "rm_ka", isOwn: true),
        Story(avatar: "lavanda", accountName: "lavanda123"),
        Story(avatar: "lavanda", accountName: "lavanda123"),
        Story(avatar: "lavanda", accountName: "lavanda123"),
        Story(avatar: "lavanda", accountName: "lavanda123"),
        Story(avatar: "lavanda", accountName: "lavanda123"),
        Story(avatar: "lavanda", accountName: "lavanda123")
    ]

    private let posts = [
        Post(
            avatar: "nat_geo_wild",
            accountName: "nat_geo_wild",
            postImages: ["natGeoImage1", "natGeoImage2", "natGeoImage3"],
            likesCount: 201,
            postDescription: """
            В нашем птичьем кинозале сегодня смотрим отличный  фильм «Планета Птиц». \
            Великолепные кадры, потрясающая съемка… Как они горды и прекрасны, \
            эти крылатые создания! Мы должны их беречь!
            """
        ),
        Post(
            avatar: "turAvatar",
            accountName: "tur_v_dagestan",
            postImages: ["turPostImage1", "turPostImage2"],
            likesCount: 201,
            postDescription: "Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        ),
    ]

    var storiesCount: Int {
        stories.count
    }

    var postsCount: Int {
        posts.count
    }

    func getPost(byIndex index: Int) -> Post {
        posts[index]
    }

    func getPosts() -> [Post] {
        posts
    }

    func getStories() -> [Story] {
        stories
    }
}
