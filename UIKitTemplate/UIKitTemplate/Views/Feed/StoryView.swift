// StoryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// История
final class StoryView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let avatarSize = 62.0
        static let avatarCornerRadius = 30.0
        static let accountfontSize = 8.0
        static let storyWidth = 74.0
        static let ownStoryText = "Ваша история"
    }

    // MARK: - Visual Components

    private lazy var avatarImageView: UIImageView = {
        let view = AvatarImageView(image: UIImage(named: story.account.avatar))
        view.size = Constants.avatarSize
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.whiteMain.cgColor
        return view
    }()

    private lazy var accountNameLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: Constants.accountfontSize)
        label.textColor = story.isOwn ? .grayMain : .blackMain
        label.text = story.isOwn ? Constants.ownStoryText : story.account.name
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Public Properties

    let story: Story

    // MARK: - Initializers

    init(story: Story) {
        self.story = story
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(avatarImageView)
        addSubview(accountNameLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        [
            widthAnchor.constraint(equalToConstant: Constants.storyWidth),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            accountNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 4),
            accountNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            accountNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            accountNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ].activate()
    }
}
