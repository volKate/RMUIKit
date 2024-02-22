// DataProvider.swift
// Copyright © RoadMap. All rights reserved.

/// Моки для приложения
struct DataProvider {
    /// Виды секций ленты
    enum FeedSectionType {
        /// первый пост
        case firstPost
        /// остальные посты
        case posts
        /// истории
        case stories
        /// рекоммендации
        case recommendation
    }

    /// Виды секций профиля
    enum ProfileSectionType {
        ///  Шапка профиля
        case accountInfo
        /// Актуальные истории
        case highlights
        /// Коллекция постов
        case postsGrid
    }

    /// порядок секций в ленте
    let feedSections = [FeedSectionType.stories, .firstPost, .recommendation, .posts]

    /// Порядок секций в профиле
    let profileSections = [ProfileSectionType.accountInfo, .highlights, .postsGrid]

    /// аккаунт залогиненного юзера
    let currentUserAccount = Account(name: "rm_ka", avatar: "rm_ka")
    /// все аккаунты
    var accounts = [
        Account(name: "lavanda123", avatar: "lavanda"),
        Account(name: "nat_geo_wild", avatar: "nat_geo_wild"),
        Account(name: "mallorca_resort", avatar: "mallorca_resort"),
        Account(name: "shufik48", avatar: "shufik_48"),
        Account(name: "12miho", avatar: "12miho"),
        Account(name: "rock_johnson", avatar: "rock_johnson"),
        Account(name: "tur_v_dagestan", avatar: "turAvatar")
    ]

    /// все нотификации
    var allNotifications: [LinkNotification] {
        [
            LinkNotification(
                account: accounts[0],
                message: "понравился ваш комментарий: \"Очень красиво!\"",
                hoursAgo: 12,
                postThumbnail: "postImage1"
            ),
            LinkNotification(
                account: accounts[0],
                message: "упомянул(-а) вас в комментарии: @rm_ka Спасибо!",
                hoursAgo: 12,
                postThumbnail: "postImage1"
            ),
            LinkNotification(
                account: accounts[0],
                message: "понравился ваш комментарий: \"Это где?\"",
                hoursAgo: 72,
                postThumbnail: "postImage2"
            ),
            LinkNotification(
                account: accounts[4],
                message: "появился(-ась) в RMLink. Вы можете быть знакомы",
                hoursAgo: 72,
                isSubscribed: false
            ),
            LinkNotification(
                account: accounts[0],
                message: "подписался(-ась) на ваши новости",
                hoursAgo: 120,
                isSubscribed: true
            ),
            LinkNotification(
                account: accounts[0],
                message: "понравился ваш комментарий: \"Ты вернулась?\"",
                hoursAgo: 168,
                postThumbnail: "postImage2"
            ),
            LinkNotification(
                account: accounts[3],
                message: "появился(-ась) в RMLink. Вы можете быть знакомы",
                hoursAgo: 192,
                isSubscribed: false
            ),
            LinkNotification(
                account: accounts[5],
                message: "появился(-ась) в RMLink. Вы можете быть знакомы",
                hoursAgo: 192,
                isSubscribed: false
            ),
        ]
    }

    /// нотификации за последние 24 часа
    var todaysNotifications: [LinkNotification] {
        allNotifications.filter { $0.hoursAgo < 25 }
    }

    /// нотификации старше одного дня
    var thisWeekNotifications: [LinkNotification] {
        allNotifications.filter { $0.hoursAgo > 24 }
    }

    /// заголовки груп нотфикаций
    let notificationsTableHeaders = ["Сегодня", "На этой неделе"]
    /// нотификации по секциям
    var notificationsBySection: [[LinkNotification]] {
        [todaysNotifications, thisWeekNotifications]
    }

    /// все посты
    private var allPosts: [Post] {
        [
            Post(
                account: accounts[1],
                postImages: ["natGeoImage1", "natGeoImage2", "natGeoImage3"],
                likesCount: 201,
                postDescription: """
                В нашем птичьем кинозале сегодня смотрим отличный  фильм «Планета Птиц». \
                Великолепные кадры, потрясающая съемка… Как они горды и прекрасны, \
                эти крылатые создания! Мы должны их беречь!
                """
            ),
            Post(
                account: accounts[6],
                postImages: ["turPostImage1", "turPostImage2"],
                likesCount: 201,
                postDescription: "Насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
            ),
        ]
    }

    /// первый пост
    var firstPost: Post {
        allPosts[0]
    }

    /// все посты в секции "остальные посты"
    var posts: [Post] {
        Array(allPosts[1...])
    }

    /// получение поста по индексу
    func getPost(byIndex index: Int) -> Post {
        posts[index]
    }

    /// все истории
    var stories: [Story] {
        [
            Story(account: currentUserAccount, isOwn: true),
            Story(account: accounts[1]),
            Story(account: accounts[1]),
            Story(account: accounts[0]),
            Story(account: accounts[0]),
            Story(account: accounts[0]),
            Story(account: accounts[0])
        ]
    }

    /// все рекоммендации
    var recommendations: [Recommendation] {
        [
            Recommendation(account: accounts[3]),
            Recommendation(account: accounts[2])
        ]
    }
}
