// PostHeaderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Верхняя панель поста
final class PostHeaderView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let menuButtonImage = "ellipsis"
    }

    // MARK: - Visual Components

    private let avatarImageView = AvatarImageView()

    private let accountNameLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let menuButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: Constants.menuButtonImage),
            for: .normal
        )
        button.tintColor = .blackMain
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Public Properties

    var post: Post? {
        didSet {
            if let post {
                avatarImageView.image = UIImage(named: post.account.avatar)
                accountNameLabel.text = post.account.name
            }
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        avatarImageView.size = 30.0
        [avatarImageView, accountNameLabel, menuButton].forEach { addSubview($0) }

        translatesAutoresizingMaskIntoConstraints = false
        menuButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        [
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),

            accountNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 6),
            accountNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            menuButton.leadingAnchor.constraint(equalTo: accountNameLabel.trailingAnchor, constant: 10),
            menuButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalTo: menuButton.trailingAnchor, constant: 9),
        ].activate()
    }
}
