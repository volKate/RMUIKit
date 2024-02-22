// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран профиля
final class ProfileViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let screenTitle = "Профиль"
        static let addPostButtonImage = "plus.app"
        static let menuButtonImage = "line.3.horizontal"
    }

    // MARK: - Private Properties

    private let dataProvider = DataProvider()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
    }

    // MARK: - Private Methods

    private func setupNavigationItem() {
        let addPostButton = makeBarButtonItem(
            image: UIImage(systemName: Constants.addPostButtonImage)
        )
        let menuButton = makeBarButtonItem(image: UIImage(systemName: Constants.menuButtonImage))
        let lockButton = makeBarButtonItem(image: .lock)
        let accountButton = makeBarButtonItem(text: dataProvider.currentUserAccount.name)
        navigationItem.setRightBarButtonItems([menuButton, addPostButton], animated: false)
        navigationItem.setLeftBarButtonItems([lockButton, accountButton], animated: false)
    }

    private func makeBarButtonItem(image: UIImage? = nil, text: String? = nil) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.tintColor = .blackMain
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .verdanaBold(ofSize: 18)
        button.titleLabel?.textColor = .blackMain
        button.disableAutoresizingMask()
        if text == nil {
            button.widthAnchor.constraint(equalToConstant: 24).activate()
        }
        return UIBarButtonItem(customView: button)
    }
}
