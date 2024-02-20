// RecommendationView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Рекоммендация аккаунта с возможностью подписаться
final class RecommendationView: UIView {
    private enum Constants {
        static let subscribeButtonText = "Подписаться"
    }

    private let accountImageView = AvatarImageView()

    private lazy var accountNameLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 10)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subscribeButton = SubscribeButton()

    var account: Account? {
        didSet {
            if let account {
                accountImageView.image = UIImage(named: account.avatar)
                accountNameLabel.text = account.name
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
