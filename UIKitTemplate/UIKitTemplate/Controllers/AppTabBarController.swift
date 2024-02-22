// AppTabBarController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таб бар приложения
final class AppTabBarController: UITabBarController {
    // MARK: - Constants

    enum Constants {
        static let feedTitle = "Лента"
        static let notificationsTitle = "Уведомления"
        static let profileTitle = "Профиль"
    }

    // MARK: - Visual Components

    private let topBorder: UIView = {
        let view = UIView()
        view.backgroundColor = .black01
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    // MARK: - Private Methods

    private func setupTabBar() {
        setViewControllers([
            createProfileNavigationController(),
            createFeedNavigationController(),
            createNotificationsNavigationController(),

        ], animated: false)

        setupAppearance()
        setupBorderTop()
    }

    private func setupAppearance() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = .systemBackground
        UITabBar.appearance().tintColor = .blueMain
        UITabBarItem.appearance().setTitleTextAttributes([
            .foregroundColor: UIColor.blueMain
        ], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([
            .font: UIFont.verdana(ofSize: 10) ?? UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor.black
        ], for: .normal)
    }

    private func setupBorderTop() {
        tabBar.addSubview(topBorder)
        [
            topBorder.topAnchor.constraint(equalTo: tabBar.topAnchor),
            topBorder.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            topBorder.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor)
        ].forEach { $0.isActive = true }
    }

    private func createFeedNavigationController() -> UINavigationController {
        let feedNavigationController = UINavigationController(rootViewController: FeedViewController())
        feedNavigationController.tabBarItem = UITabBarItem(
            title: Constants.feedTitle,
            image: .feedBarIcon.withRenderingMode(.alwaysOriginal),
            selectedImage: .feedBarIcon
        )
        return feedNavigationController
    }

    private func createNotificationsNavigationController() -> UINavigationController {
        let notificationsNavigationController =
            UINavigationController(rootViewController: NotificationsViewController())
        notificationsNavigationController.tabBarItem = UITabBarItem(
            title: Constants.notificationsTitle,
            image: .notificationsBarIcon.withRenderingMode(.alwaysOriginal),
            selectedImage: .notificationsBarIcon
        )
        return notificationsNavigationController
    }

    private func createProfileNavigationController() -> UINavigationController {
        let profileNavigationController = UINavigationController(rootViewController: ProfileViewController())
        profileNavigationController.tabBarItem = UITabBarItem(
            title: Constants.profileTitle,
            image: .profileBarIcon.withRenderingMode(.alwaysOriginal),
            selectedImage: .profileBarIcon
        )
        return profileNavigationController
    }
}
