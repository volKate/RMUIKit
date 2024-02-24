// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = scene as? UIWindowScene else { return }
        configureWindow(scene)
    }

    private func configureWindow(_ scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UINavigationController(rootViewController: MenuViewController())
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
}
