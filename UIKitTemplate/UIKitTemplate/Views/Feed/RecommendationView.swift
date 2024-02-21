// RecommendationView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Рекоммендация аккаунта с возможностью подписаться
final class RecommendationView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let subscribeButtonText = "Подписаться"
    }

    // MARK: - Visual Components

    private let accountImageView = AvatarImageView()

    private let accountNameLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 10)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subscribeButton = SubscribeButton()

    // MARK: - Public Properties

    var account: Account? {
        didSet {
            if let account {
                accountImageView.image = UIImage(named: account.avatar)
                accountNameLabel.text = account.name
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
        accountImageView.size = 115.0
        backgroundColor = .whiteMain
        addSubview(accountImageView)
        addSubview(accountNameLabel)
        addSubview(subscribeButton)

        setupConstraints()
    }

    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        [
            widthAnchor.constraint(greaterThanOrEqualToConstant: 185),
            accountImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            accountImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            accountNameLabel.topAnchor.constraint(equalTo: accountImageView.bottomAnchor, constant: 5),
            accountNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            accountNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subscribeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            subscribeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            bottomAnchor.constraint(equalTo: subscribeButton.bottomAnchor, constant: 14)
        ].activate()
    }
}
