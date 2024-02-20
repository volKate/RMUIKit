// FeedDataProvider.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные для ленты
struct FeedDataProvider {
    private let stories = [
        Story(avatar: "userAvatar", accountName: "rm_ka", isOwn: true),
        Story(avatar: "lavanda", accountName: "lavanda123"),
        Story(avatar: "lavanda", accountName: "lavanda123"),
        Story(avatar: "lavanda", accountName: "lavanda123"),
        Story(avatar: "lavanda", accountName: "lavanda123"),
        Story(avatar: "lavanda", accountName: "lavanda123"),
        Story(avatar: "lavanda", accountName: "lavanda123")
    ]

    private let posts = [
        Post(
            avatar: "turAvatar",
            accountName: "tur_v_dagestan",
            postImages: ["turPostImage1", "turPostImage2"],
            likesCount: 201,
            postDescription: "Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
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
