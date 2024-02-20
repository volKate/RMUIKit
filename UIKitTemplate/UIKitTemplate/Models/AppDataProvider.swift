// AppDataProvider.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные для ленты
struct AppDataProvider {
    private(set) static var shared = AppDataProvider()

    let currentUserAvatar = "rm_ka"
    private let accounts = [
        Account(name: "rm_ka", avatar: "rm_ka"),
        Account(name: "lavanda123", avatar: "lavanda"),
        Account(name: "nat_geo_wild", avatar: "nat_geo_wild"),
        Account(name: "mallorca_resort", avatar: "mallorca_resort"),
        Account(name: "shufik48", avatar: "shufik_48"),
        Account(name: "12miho", avatar: "12miho"),
        Account(name: "rock_johnson", avatar: "rock_johnson")
    ]

    var allNotifications: [LinkNotification] {
        [
            LinkNotification(
                account: accounts[1],
                message: "понравился ваш комментарий: \"Очень красиво!\"",
                hoursAgo: 12,
                postThumbnail: "postImage1"
            ),
            LinkNotification(
                account: accounts[1],
                message: "упомянул(-а) вас в комментарии: @rm_ka Спасибо!",
                hoursAgo: 12,
                postThumbnail: "postImage1"
            ),
            LinkNotification(
                account: accounts[1],
                message: "понравился ваш комментарий: \"Это где?\"",
                hoursAgo: 72,
                postThumbnail: "postImage2"
            ),
            LinkNotification(
                account: accounts[5],
                message: "появился(-ась) в RMLink. Вы можете быть знакомы",
                hoursAgo: 72
            ),
            LinkNotification(
                account: accounts[1],
                message: "подписался(-ась) на ваши новости",
                hoursAgo: 120,
                isSubscribed: true
            ),
            LinkNotification(
                account: accounts[1],
                message: "понравился ваш комментарий: \"Ты вернулась?\"",
                hoursAgo: 168,
                postThumbnail: "postImage2"
            ),
            LinkNotification(
                account: accounts[4],
                message: "появился(-ась) в RMLink. Вы можете быть знакомы",
                hoursAgo: 192
            ),
            LinkNotification(
                account: accounts[6],
                message: "появился(-ась) в RMLink. Вы можете быть знакомы",
                hoursAgo: 192
            ),
        ]
    }

    var todaysNotifications: [LinkNotification] {
        allNotifications.filter { $0.hoursAgo < 25 }
    }

    var thisWeekNotifications: [LinkNotification] {
        allNotifications.filter { $0.hoursAgo > 24 }
    }

    var posts: [Post] {
        [
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
    }

    func getAccounts() -> [Account] {
        accounts
    }

    func getPost(byIndex index: Int) -> Post {
        posts[index]
    }

    func getPosts() -> [Post] {
        posts
    }

    func getStories() -> [Story] {
        [
            Story(account: accounts[0], isOwn: true),
            Story(account: accounts[2]),
            Story(account: accounts[2]),
            Story(account: accounts[1]),
            Story(account: accounts[1]),
            Story(account: accounts[1]),
            Story(account: accounts[1])
        ]
    }

    func getRecommendations() -> [Recommendation] {
        [
            Recommendation(account: accounts[3]),
            Recommendation(account: accounts[4])
        ]
    }
}
